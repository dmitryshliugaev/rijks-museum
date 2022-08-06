//
//  MockListRouter.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import XCTest
@testable import rijksmuseum

class MockListRouter: ListModulesOutput {
    var isDidSelectPictureCalled = false
    var objectNumber = ""
    
    func didSelectPicture(objectNumber: String) {
        isDidSelectPictureCalled = true
        self.objectNumber = objectNumber
    }
}
