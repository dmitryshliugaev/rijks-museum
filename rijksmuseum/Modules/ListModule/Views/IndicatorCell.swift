//
//  IndicatorCell.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 14/07/2022.
//

import UIKit

final class IndicatorCell: UICollectionViewCell {
    
    var inidicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        contentView.addSubview(inidicator)
        inidicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inidicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            inidicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        inidicator.startAnimating()
    }
    
}
