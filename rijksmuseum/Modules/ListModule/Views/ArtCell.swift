//
//  ArtCell.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit
import Kingfisher

class ArtCell: UICollectionViewCell {
    var imageView : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .gray
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        return img
    }()
    
    var descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    var state : ArtModel? {
        didSet {
            assignPicture()
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
        state = nil
        imageView.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        
    }
    
    deinit {
        state = nil
    }
    
    func setupViews(){
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        backgroundColor = .white
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
    }
    
    func setupConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    func assignPicture(){
        guard let state = state else {
            return
        }
        
        imageView.kf.setImage(with: URL(string: state.webImage.getURLForSmallImageSize())!) { res in
            if case .success(let value)  = res   {
                ImageCache.default.store(value.image, forKey: state.webImage.getURLForSmallImageSize())
            }
        }
    }
}
