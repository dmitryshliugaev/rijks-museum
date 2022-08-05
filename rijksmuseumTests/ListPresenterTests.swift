//
//  ListPresenterTests.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import XCTest

@testable import rijksmuseum

final class ListPresenterTests: XCTestCase {
    var presenter: ListPresenter!
    var view: MockListView!
    var repository: MockRijksRepository!
    var router: MockRouter!
    
    let objectNumber = "SK-C-149"
    
    override func setUpWithError() throws {
        presenter = ListPresenter()
        view = MockListView()
        router = MockRouter()
        
        presenter.view = view
        presenter.router = router
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        router = nil
        repository = nil
    }
    
    func testDidLoad_FetchDataSuccess() {
        // Given
        repository = MockRijksRepository(mockState: .succes)
        presenter.repository = repository
        
        // When
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        XCTAssertFalse(presenter.numberOfSections() == 0)
        XCTAssertTrue(view.isUpdatePicturesListCalled)
        XCTAssertFalse(view.isShowErrorAlertCalled)
    }
    
    func testDidLoad_FetchDataFailure() {
        // Given
        repository = MockRijksRepository(mockState: .error)
        presenter.repository = repository
        
        // When
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        XCTAssertTrue(presenter.numberOfSections() == 0)
        XCTAssertFalse(view.isUpdatePicturesListCalled)
        XCTAssertTrue(view.isShowErrorAlertCalled)
    }
    
    func testSelectPicture_DidCall() throws {
        // Given
        repository = MockRijksRepository(mockState: .succes)
        presenter.repository = repository
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // When
        presenter.selectPicture(indexPath: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(router.isDidSelectPicture)
        XCTAssertEqual(router.objectNumber, objectNumber)
    }
    
    func testLoadNewPage_FetchDataSuccess() throws {
        // Given
        repository = MockRijksRepository(mockState: .succes)
        presenter.repository = repository
        
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        view.isUpdatePicturesListCalled = false
        view.isShowErrorAlertCalled = false
        
        // When
        presenter.loadNewPage(currentItem: IndexPath(row: 29, section: 0))
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        // Then
        XCTAssertTrue(view.isUpdatePicturesListCalled)
        XCTAssertFalse(view.isShowErrorAlertCalled)
    }
    
    func testLoadNewPage_FetchDataFailure() throws {
        // Given
        repository = MockRijksRepository(mockState: .succes)
        presenter.repository = repository
        
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.3)
        
        view.isUpdatePicturesListCalled = false
        view.isShowErrorAlertCalled = false
        
        repository = MockRijksRepository(mockState: .error)
        presenter.repository = repository
        
        // When
        presenter.loadNewPage(currentItem: IndexPath(row: 29, section: 0))
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.5)
        
        // Then
        XCTAssertFalse(view.isUpdatePicturesListCalled)
        XCTAssertTrue(view.isShowErrorAlertCalled)
    }
}
