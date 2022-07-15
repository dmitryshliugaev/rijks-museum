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
        let (view, _) = ListConfigure.configure(router: self)
        navigationController.pushViewController(view, animated: false)
    }
    
    func pushDetailPageView(objectNumber: String) {
        let (view, presenter) = DetailPageConfigure.configure(router: self)
        presenter.configure(objectNumber: objectNumber)
        navigationController.pushViewController(view, animated: true)
        
    }
}

extension MainCoordinator: ListModulesOutput {
    func didSelectPicture(objectNumber: String) {
        pushDetailPageView(objectNumber: objectNumber)
    }
}

extension MainCoordinator: DetailPageModulesOutput {
    func didBack() {
        navigationController.popToRootViewController(animated: true)
    }
}
