//
//  DetailPageConfigure.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation
import UIKit

final class DetailPageConfigure {
    static func configure(router: DetailPageModulesOutput) -> (view: some UIViewController, presenter: DetailPageModulesInput) {
        let view = DetailPageView()
        let presentor = DetailPagePresentor()
        presentor.artNetworkService = ArtNetworkService()
        view.output = presentor
        presentor.view = view
        presentor.router = router
        
        return (view, presentor)
    }
}
