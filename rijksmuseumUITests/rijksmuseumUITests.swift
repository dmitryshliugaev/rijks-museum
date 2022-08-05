//
//  rijksmuseumUITests.swift
//  rijksmuseumUITests
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import XCTest

class rijksmuseumUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainFlow() throws {
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
    
    func testPaginationCollectionVIew() throws {
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
