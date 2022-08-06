//
//  MockDetailRouter.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 06/08/2022.
//

import XCTest
@testable import rijksmuseum

class MockDetailRouter: DetailPageModulesOutput {
    var isDidBackCalled = false
    
    func didBack() {
        isDidBackCalled = true
    }
}
