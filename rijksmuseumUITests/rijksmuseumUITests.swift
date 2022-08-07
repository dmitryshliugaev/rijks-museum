//
//  rijksmuseumUITests.swift
//  rijksmuseumUITests
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import XCTest

class rijksmuseumUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testLoadCollection_andOpenDetailView() throws {
        let app = XCUIApplication()
        app.launch()
        
        sleep(5)
        
        app.collectionViews.cells.element(boundBy: 0).tap()
        
        let titleLabel = app.staticTexts["titleLabel"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: titleLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(titleLabel.exists)
    }
    
    func testCollectionView_Pagination() throws {
        let app = XCUIApplication()
        app.launch()
        
        sleep(5)
        
        let maxScrolls = 20
        var count = 0
        
        while count < maxScrolls {
            app.swipeUp()
            sleep(1)
            
            let elem = app.staticTexts["headerLabel"].firstMatch
            if elem.exists, elem.label == "Page 2" {
                XCTAssertTrue(true)
                return
            }
            
            count += 1
        }
        
        XCTFail()
    }
}
