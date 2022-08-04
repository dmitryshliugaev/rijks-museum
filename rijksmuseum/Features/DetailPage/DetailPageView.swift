//
//  DetailPageView.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit

protocol DetailPageViewInput: AnyObject {
    func configure(model: ArtDetails)
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void, noHandler: @escaping () -> Void)
}

protocol DetailPageViewOutput {
    func didLoad()
}


final class DetailPageView: UIViewController, DetailPageViewInput {
    
    // MARK: - Dependencies
    var output: DetailPageViewOutput?
    
    // MARK: - Properties
    private lazy var pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.backgroundColor = .lightGray
        pictureView.contentMode = .scaleAspectFill
        pictureView.clipsToBounds = true
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.setContentHuggingPriority(.defaultLow, for: .vertical)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        return pictureView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        setupLabel(label: titleLabel)
        titleLabel.accessibilityIdentifier = "titleLabel"
        return titleLabel
    }()
    
    private lazy var principalOrFirstMakerLabel: UILabel = {
        let principalOrFirstMakerLabel = UILabel()
        principalOrFirstMakerLabel.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        setupLabel(label: principalOrFirstMakerLabel)
        return principalOrFirstMakerLabel
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.systemFont(ofSize: Constants.Font.small)
        descriptionTextView.contentInsetAdjustmentBehavior = .automatic
        descriptionTextView.textColor = .black
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.backgroundColor = .white
        return descriptionTextView
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(pictureView)
        view.addSubview(titleLabel)
        view.addSubview(principalOrFirstMakerLabel)
        view.addSubview(descriptionTextView)
        NSLayoutConstraint.activate(layoutConstraints)
        setupDescriptionViewsConstraints()
        
        navigationItem.largeTitleDisplayMode = .never
        
        output?.didLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private lazy var layoutConstraints: [NSLayoutConstraint] = {
        return [
            pictureView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pictureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pictureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pictureView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height / 2),
            
            titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: Constants.UI.mediumPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.mediumPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.mediumPadding),
            
            principalOrFirstMakerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.UI.mediumPadding),
            principalOrFirstMakerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.mediumPadding),
            principalOrFirstMakerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.mediumPadding),
            
            descriptionTextView.topAnchor.constraint(equalTo: principalOrFirstMakerLabel.bottomAnchor, constant: Constants.UI.mediumPadding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.mediumPadding),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.mediumPadding),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.UI.mediumPadding )
        ]
    }()
    
    private func setupDescriptionViewsConstraints() {
        principalOrFirstMakerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        descriptionTextView.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .vertical)
    }
    
    private func setupLabel(label: UILabel) {
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textAlignment = .natural
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
        if let url = URL(string: model.webImage.url) {
            Dependency.sharedInstance.imageDownloader.downloadImage(from: url) { result in
                switch result {
                case .success(let image):
                    self.pictureView.image = image
                case .failure(_):
                    self.pictureView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            }
        }
        
        titleLabel.text = model.longTitle
        principalOrFirstMakerLabel.text = model.principalOrFirstMaker
        descriptionTextView.text = model.description
    }
}
