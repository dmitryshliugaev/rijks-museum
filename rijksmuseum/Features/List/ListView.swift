//
//  ListView.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation
import UIKit

protocol ListViewInput: AnyObject {
    func updatePicturesList()
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void)
}

protocol ListViewOutput {
    func didLoad()
    func selectPicture(indexPath: IndexPath)
    func loadNewPage(currentItem: IndexPath)
    func isLoading() -> Bool
}

final class ListView: UIViewController, ListViewInput {
    
    //MARK: - Dependencies
    var output: ListViewOutput?
    var itemSource: ListViewItemsSourcing?
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.UI.mediumPadding
        layout.minimumInteritemSpacing = Constants.UI.mediumPadding
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.UI.mediumPadding, bottom: 0, right: Constants.UI.mediumPadding)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(ArtCell.self, forCellWithReuseIdentifier: artCellID)
        collectionView.register(IndicatorCell.self, forCellWithReuseIdentifier: indicatorCellID)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewID)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var loadImageView: UIImageView = {
        let loadImageView = UIImageView(image: UIImage(named: "babushkaReading"))
        loadImageView.contentMode = .scaleAspectFill
        loadImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadImageView)
        return loadImageView
    }()
    
    private var isFirstLoading = true
    
    //MARK: - Constants
    private let artCellID = "ArtCell"
    private let indicatorCellID = "IndicatorCell"
    private let headerViewID = "HeaderView"
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLayoutConstraint.activate(layoutConstraints)
        output?.didLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private lazy var layoutConstraints: [NSLayoutConstraint] = {
        return [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadImageView.topAnchor.constraint(equalTo: view.topAnchor),
            loadImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
    }()
    
    //MARK: - Error handling
    
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void) {
        let alertView = UIAlertController(title: "",
                                          message: message,
                                          preferredStyle: .alert)
        
        let tryAgainHandler = UIAlertAction(title: "tryAgain".localizedString, style: .default) { _ in
            tryAgainHandler()
        }
        let noAction = UIAlertAction(title: "no".localizedString, style: .default)
        
        alertView.addAction(tryAgainHandler)
        alertView.addAction(noAction)
        
        present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - ListViewInput
    
    func updatePicturesList() {
        self.collectionView.reloadData()
        
        if self.isFirstLoading {
            self.isFirstLoading = false
            self.loadImageView.removeFromSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ListView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return itemSource?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemsCount = itemSource?.itemsInSection(index: section),
              let itemSourceSections = itemSource?.numberOfSections() else {
            return 0
        }
        
        if itemsCount == 0 {
            return 0
        }
        
        if section == itemSourceSections - 1 {
            return itemsCount + 1
        } else {
            return itemsCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemSourceRow = itemSource?.itemsInSection(index: indexPath.section),
              let itemSourceSections = itemSource?.numberOfSections() else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == itemSourceRow && indexPath.section == itemSourceSections - 1 {
            guard let indicatorCell: IndicatorCell = collectionView.dequeueReusableCell(withReuseIdentifier: indicatorCellID,
                                                                                        for: indexPath) as? IndicatorCell else {
                return UICollectionViewCell()
            }
            indicatorCell.inidicator.startAnimating()
            return indicatorCell
        } else {
            guard let artCell: ArtCell = collectionView.dequeueReusableCell(withReuseIdentifier: artCellID,
                                                                            for: indexPath) as? ArtCell else {
                return UICollectionViewCell()
            }
            artCell.model = itemSource?.itemModelFor(indexPath: indexPath)
            return artCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        output?.loadNewPage(currentItem: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            header.textLabel.text = "header.title".localizedString + "\(indexPath.section + 1)"
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.selectPicture(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        let itemsCount = itemSource?.itemsInSection(index: indexPath.section)
        
        if (indexPath.row == itemsCount ) {
            return CGSize(width: size.width , height: Constants.List.indicatorHeight)
        } else {
            return CGSize(width:(view.bounds.width - Constants.UI.largePadding) / 2, height: Constants.List.artCellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.List.headerHeight)
    }
}
