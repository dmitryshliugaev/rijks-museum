//
//  MockDetailView.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 06/08/2022.
//

import XCTest
@testable import rijksmuseum

class MockDetailView: DetailPageViewInput {
    var isConfigureCalled = false
    var isShowErrorAlertCalled = false
    var tryAgainHandlerShouldBeCall = false
    var noHandlerShouldBeCall = false
    
    var model: ArtDetails?
    
    func configure(model: ArtDetails) {
        isConfigureCalled = true
        self.model = model
    }
    
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void, noHandler: @escaping () -> Void) {
        isShowErrorAlertCalled = true
        
        if tryAgainHandlerShouldBeCall {
            tryAgainHandler()
        }
        
        if noHandlerShouldBeCall {
            noHandler()
        }
    }
}

