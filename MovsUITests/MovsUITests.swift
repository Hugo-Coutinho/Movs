//
//  MovsUITests.swift
//  MovsUITests
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest

class MovsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFavoriteClickedAllApplication() {
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).buttons["favorite gray icon"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["favorite full icon"]/*[[".cells.buttons[\"favorite full icon\"]",".buttons[\"favorite full icon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let app = XCUIApplication()
        let collectionViewsQuery2 = app.collectionViews
        collectionViewsQuery2.children(matching: .cell).element(boundBy: 2).buttons["favorite gray icon"].tap()
        collectionViewsQuery2/*@START_MENU_TOKEN@*/.staticTexts["The Blacklist"]/*[[".cells.staticTexts[\"The Blacklist\"]",".staticTexts[\"The Blacklist\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["favorite full icon"]/*[[".scrollViews.buttons[\"favorite full icon\"]",".buttons[\"favorite full icon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Show"].buttons["Tv Shows"].tap()
        
    }
}
