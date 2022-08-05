//
//  MockRouter.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import XCTest
@testable import rijksmuseum

class MockRouter: ListModulesOutput {
    var isDidSelectPicture = false
    var objectNumber = ""
    
    func didSelectPicture(objectNumber: String) {
        isDidSelectPicture = true
        self.objectNumber = objectNumber
    }
}
