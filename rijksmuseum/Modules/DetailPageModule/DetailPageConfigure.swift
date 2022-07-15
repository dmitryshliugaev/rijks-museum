//
//  DetailPageConfigure.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation
import UIKit

final class DetailPageConfigure {
    static func configure(router: DetailPageModulesOutput) -> (view: UIViewController, presenter: DetailPageModulesInput) {
        let view = DetailPageView()
        let presenter = DetailPagePresenter()
        presenter.artNetworkService = ArtNetworkService()
        view.output = presenter
        presenter.view = view
        presenter.router = router
        
        return (view, presenter)
    }
}
