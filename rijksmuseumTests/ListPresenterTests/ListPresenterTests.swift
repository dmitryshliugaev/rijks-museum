//
//  ListPresenterTests.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 15/07/2022.
//

import XCTest
@testable import rijksmuseum

class ListPresenterTests: XCTestCase {
    
    var presenter: ListViewOutput!
    var viewMock: ListViewMock!
    var artNetworkServiceMock: ArtNetworkServiceMock!
    var routerMock: RouterMock!
    let objectNumber = "objectNumber"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let presenter = ListPresenter()
        
        viewMock = ListViewMock()
        artNetworkServiceMock = ArtNetworkServiceMock()
        routerMock = RouterMock()
        
        presenter.view = viewMock
        presenter.artNetworkService = artNetworkServiceMock
        presenter.router = routerMock
        presenter.arts = [0: [ArtListItem(id: "id", objectNumber: objectNumber, title: nil, webImage: nil)]]
        
        self.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        viewMock = nil
        artNetworkServiceMock = nil
        routerMock = nil
    }
    
    func testDidLoadCall() throws {
        // given
        
        // when
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.5)
        
        // then
        XCTAssertTrue(viewMock.isUpdatePicturesListCalled)
        XCTAssertFalse(viewMock.isShowErrorAlertCalled)
    }
    
    func testDidLoadFailed() throws {
        // given
        artNetworkServiceMock.isSuccessMode = false
        
        // when
        presenter.didLoad()
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.5)
        
        // then
        XCTAssertTrue(viewMock.isShowErrorAlertCalled)
        XCTAssertFalse(viewMock.isUpdatePicturesListCalled)
    }
    
    func testSelectPictureDidCall() throws {
        // given
        
        // when
        presenter.selectPicture(indexPath: IndexPath(row: 0, section: 0))
        
        // then
        XCTAssertTrue(routerMock.isDidSelectPicture)
    }
    
    func testSelectPictureSendRightObjectNumer() throws {
        // given
        
        // when
        presenter.selectPicture(indexPath: IndexPath(row: 0, section: 0))
        
        // then
        XCTAssertEqual(routerMock.objectNumber, objectNumber)
    }
    
    func testLoadNewPageDidCall() throws {
        // given
        
        // when
        presenter.loadNewPage(currentItem: IndexPath(row: 0, section: 0))
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.5)
        
        // then
        XCTAssertTrue(viewMock.isUpdatePicturesListCalled)
        XCTAssertFalse(viewMock.isShowErrorAlertCalled)
    }
    
    func testLoadNewPageFailed() throws {
        // given
        artNetworkServiceMock.isSuccessMode = false
        
        // when
        presenter.loadNewPage(currentItem: IndexPath(row: 0, section: 0))
        _ = XCTWaiter.wait(for: [.init()], timeout: 0.5)
        
        // then
        XCTAssertFalse(viewMock.isUpdatePicturesListCalled)
        XCTAssertTrue(viewMock.isShowErrorAlertCalled)
    }
    
    func testIsLoadingFalse() throws {
        // given
        
        // when
        
        // then
        XCTAssertFalse(presenter.isLoading())
    }
}
