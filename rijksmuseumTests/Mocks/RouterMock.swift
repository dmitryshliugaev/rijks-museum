//
//  RouterMock.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 15/07/2022.
//

import XCTest
@testable import rijksmuseum

class RouterMock: ListModulesOutput {
    var isDidSelectPicture = false
    var objectNumber = ""
    
    func didSelectPicture(objectNumber: String) {
        isDidSelectPicture = true
        self.objectNumber = objectNumber
    }
}
