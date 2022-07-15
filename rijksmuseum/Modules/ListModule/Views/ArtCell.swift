//
//  ArtCell.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit
import Kingfisher

final class ArtCell: UICollectionViewCell {
    var imageView : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        img.image = UIImage(systemName: "")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        img.kf.indicatorType = .activity
        return img
    }()
    
    var descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.small)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    var model : ArtListItem? {
        didSet {
            assignPicture()
            
            descriptionLabel.text = model?.title
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        imageView.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
    }
    
    deinit {
        model = nil
    }
    
    func setupViews(){
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        backgroundColor = .white
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: Constants.List.imageHeight)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.UI.smallPadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.UI.smallPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.UI.smallPadding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.smallPadding)
        ])
    }
    
    func assignPicture(){
        guard let model = model else {
            return
        }
        
        if let shortUrlString = model.webImage?.getURLForSmallImageSize(),
           let url = URL(string: shortUrlString) {
            imageView.kf.setImage(with: url) { res in
                if case .success(let value)  = res   {
                    ImageCache.default.store(value.image, forKey: shortUrlString)
                }
            }
        }
    }
}
