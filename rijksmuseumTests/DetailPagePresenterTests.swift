//
//  DetailPagePresenterTests.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 06/08/2022.
//

import XCTest

@testable import rijksmuseum

class DetailPagePresenterTests: XCTestCase {
    var presenter: DetailPagePresenter!
    var view: MockDetailView!
    var repository: MockRijksRepository!
    var router: MockDetailRouter!
    
    let objectNumber = "SK-A-133"
    
    override func setUpWithError() throws {
        presenter = DetailPagePresenter()
        view = MockDetailView()
        router = MockDetailRouter()
        
        presenter.view = view
        presenter.router = router
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        router = nil
        repository = nil
    }
    
    func testDidLoad_FetchDataSuccess() throws {
        // Given
        repository = MockRijksRepository(mockState: .succes)
        presenter.repository = repository
        presenter.configure(objectNumber: objectNumber)
        
        // When
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        let unwrappedModel = try XCTUnwrap(view.model)
        XCTAssertTrue(view.isConfigureCalled)
        XCTAssertTrue(unwrappedModel.objectNumber == objectNumber)
        XCTAssertFalse(view.isShowErrorAlertCalled)
    }
    
    func testDidLoad_FetchDataFailure() throws {
        // Given
        repository = MockRijksRepository(mockState: .error)
        presenter.repository = repository
        presenter.configure(objectNumber: objectNumber)
        
        // When
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        XCTAssertFalse(view.isConfigureCalled)
        XCTAssertTrue(view.model == nil)
        XCTAssertTrue(view.isShowErrorAlertCalled)
    }
    
    func testDidLoad_FetchDataFailure_TryAgainHandlerCalled() throws {
        // Given
        repository = MockRijksRepository(mockState: .error)
        presenter.repository = repository
        presenter.configure(objectNumber: objectNumber)
        view.tryAgainHandlerShouldBeCall = true
        
        // When
        presenter.didLoad()
        
        repository = MockRijksRepository(mockState: .succes)
        presenter.repository = repository
        
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        XCTAssertTrue(view.isShowErrorAlertCalled)
        
        let unwrappedModel = try XCTUnwrap(view.model)
        XCTAssertTrue(view.isConfigureCalled)
        XCTAssertTrue(unwrappedModel.objectNumber == objectNumber)
    }
    
    func testDidLoad_FetchDataFailure_NoHandlerCalled() throws {
        // Given
        repository = MockRijksRepository(mockState: .error)
        presenter.repository = repository
        presenter.configure(objectNumber: objectNumber)
        view.noHandlerShouldBeCall = true
        
        // When
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        XCTAssertTrue(view.isShowErrorAlertCalled)
        XCTAssertTrue(router.isDidBackCalled)
    }
}
