//
//  DetailPageView.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit
import Kingfisher

protocol DetailPageViewInput: AnyObject {
    func configure(model: ArtDetails)
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void, noHandler: @escaping () -> Void)
}

protocol DetailPageViewOutput {
    func didLoad()
}


final class DetailPageView: UIViewController, DetailPageViewInput {
    
    // MARK: - Dependencies
    var output: DetailPageViewOutput!
    
    // MARK: - Properties
    private var pictureView: UIImageView!
    private var titleLabel: UILabel!
    private var principalOrFirstMakerLabel: UILabel!
    private var descriptionTextView: UITextView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupImageView()
        setupDescriptionViews()
        output.didLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private func setupImageView() {
        pictureView = UIImageView()
        pictureView.backgroundColor = .lightGray
        pictureView.contentMode = .scaleAspectFill
        pictureView.clipsToBounds = true
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        view.addSubview(pictureView)
        
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pictureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pictureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pictureView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height / 2)
        ])
        
        pictureView.kf.indicatorType = .activity
    }
    
    private func setupDescriptionViews() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        setupLabel(label: titleLabel)
        titleLabel.accessibilityIdentifier = "titleLabel"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: Constants.UI.mediumPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.mediumPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.mediumPadding)
        ])
        
        principalOrFirstMakerLabel = UILabel()
        principalOrFirstMakerLabel.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        setupLabel(label: principalOrFirstMakerLabel)
        
        NSLayoutConstraint.activate([
            principalOrFirstMakerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.UI.mediumPadding),
            principalOrFirstMakerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.mediumPadding),
            principalOrFirstMakerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.mediumPadding)
        ])
        principalOrFirstMakerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        
        
        descriptionTextView = UITextView()
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.systemFont(ofSize: Constants.Font.small)
        descriptionTextView.contentInsetAdjustmentBehavior = .automatic
        descriptionTextView.textColor = .black
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.backgroundColor = .white
        
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: principalOrFirstMakerLabel.bottomAnchor, constant: Constants.UI.mediumPadding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.mediumPadding),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.mediumPadding),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.UI.mediumPadding )
        ])
        
        descriptionTextView.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .vertical)
    }
    
    private func setupLabel(label: UILabel) {
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textAlignment = .natural
        view.addSubview(label)
    }
    
    //MARK: - Error handling
    
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void, noHandler: @escaping () -> Void) {
        let alertView = UIAlertController(title: "",
                                          message: message,
                                          preferredStyle: .alert)
        
        let tryAgainHandler = UIAlertAction(title: "tryAgain".localizedString, style: .default) { _ in
            tryAgainHandler()
        }
        let noAction = UIAlertAction(title: "no".localizedString, style: .default) { _ in
            noHandler()
        }
        
        alertView.addAction(tryAgainHandler)
        alertView.addAction(noAction)
        
        present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - DetailPageViewInput
    
    func configure(model: ArtDetails) {
        if let urlString = model.artObject.webImage?.url,
           let url = URL(string: urlString) {
            pictureView.kf.setImage(with: url) { res in
                if case .success(let value) = res   {
                    ImageCache.default.store(value.image, forKey: urlString)
                }
            }
        }
        
        titleLabel.text = model.artObject.longTitle
        principalOrFirstMakerLabel.text = model.artObject.principalOrFirstMaker
        descriptionTextView.text = model.artObject.description
    }
}
