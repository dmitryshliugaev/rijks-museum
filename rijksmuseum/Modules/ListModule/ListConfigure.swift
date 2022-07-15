//
//  ListConfigure.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation
import UIKit

final class ListConfigure {
    static func configure(router: ListModulesOutput) -> (view: UIViewController, presenter: ListModulesInput) {
        let view = ListView()
        let presenter = ListPresenter()
        view.output = presenter
        view.itemSource = presenter
        presenter.view = view
        presenter.artNetworkService = ArtNetworkService()
        presenter.router = router
        
        return (view, presenter)
    }
}
