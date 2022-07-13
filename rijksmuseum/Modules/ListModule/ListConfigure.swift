//
//  ListConfigure.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

final class ListConfigure {
    func configure() -> (view: ListView, presenter: ListPresentor) {
        let view = ListView()
        let presentor = ListPresentor()
        view.output = presentor
        presentor.view = view
        
        return (view, presentor)
    }
}
