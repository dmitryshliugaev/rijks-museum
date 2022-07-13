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
}

protocol ListViewOutput {
    func selectPicture()
}

class ListView: UIViewController, ListViewInput {
    
    // MARK: - Dependencies
    var output: ListViewOutput!
    
    // MARK: - Properties
    private var collectionView = UICollectionView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private func setupCollectionView() {
        
    }
    
    // MARK: - ListViewInput
    func updatePicturesList() {
        
    }
}
