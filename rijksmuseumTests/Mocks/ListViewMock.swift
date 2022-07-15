//
//  ListViewMock.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 15/07/2022.
//

import XCTest
@testable import rijksmuseum

class ListViewMock: ListViewInput {
    var isUpdatePicturesListCalled = false
    var isShowErrorAlertCalled = false
    
    func updatePicturesList() {
        isUpdatePicturesListCalled = true
    }
    
    func showErrorAlert(message: String, tryAgainHandler: @escaping () -> Void) {
        isShowErrorAlertCalled = true
    }
}
