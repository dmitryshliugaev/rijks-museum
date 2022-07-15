//
//  HeaderView.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 14/07/2022.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    var textLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.large)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.UI.mediumPadding),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.UI.mediumPadding),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.UI.mediumPadding),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.UI.mediumPadding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
