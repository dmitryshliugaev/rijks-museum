//
//  MainCoordinator.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    init() {}
    
    func start() {
        pushListView()
    }
    
    func pushListView() {
        let (view, _) = ListConfigure().configure()
        navigationController.pushViewController(view, animated: false)
    }
    
    func pushDetailPageView() {
        
    }
}
