//
//  ArtCell.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit

final class ArtCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        img.image = UIImage(systemName: "")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        return img
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.small)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    var model : ArtCollectionObject? {
        didSet {
            assignPicture()
            
            descriptionLabel.text = model?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        model = nil
    }
    
    deinit {
        model = nil
    }
    
    private func setup(){
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        backgroundColor = .white
        
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private lazy var layoutConstraints: [NSLayoutConstraint] = {
        return [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: Constants.List.imageHeight),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.UI.smallPadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.UI.smallPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.UI.smallPadding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.smallPadding)
        ]
    }()
    
    private func assignPicture(){
        guard let model = model else {
            return
        }
        
        if let url = URL(string: model.webImage.getURLForSmallImageSize()) {
            Dependency.sharedInstance.imageDownloader.downloadImage(from: url) { result in
                switch result {
                case .success(let image):
                    if self.model?.webImage.getURLForSmallImageSize() == url.absoluteString {
                        self.imageView.image = image
                    }
                case .failure(_):
                    self.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
}
