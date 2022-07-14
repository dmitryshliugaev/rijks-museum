//
//  ListConfigure.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation
import UIKit

final class ListConfigure {
    static func configure(router: ListModulesOutput) -> (view: some UIViewController, presenter: ListModulesInput) {
        let view = ListView()
        let presentor = ListPresentor()
        view.output = presentor
        view.itemSource = presentor
        presentor.view = view
        presentor.artNetworkService = ArtNetworkService()
        presentor.router = router
        
        return (view, presentor)
    }
}
