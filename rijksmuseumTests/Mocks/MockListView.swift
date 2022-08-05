//
//  MockListView.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import XCTest
@testable import rijksmuseum

class MockListView: ListViewInput {
    var isUpdatePicturesListCalled = false
    var isShowErrorAlertCalled = false
    
    func updatePicturesList() {
        isUpdatePicturesListCalled = true
    }
    
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void) {
        isShowErrorAlertCalled = true
    }
}
