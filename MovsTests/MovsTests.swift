//
//  MovsTests.swift
//  MovsTests
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest
@testable import Movs

class MovsTests: XCTestCase {
    
    var favHelper: FavoriteHelper!
    var db: FavoriteManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         favHelper = FavoriteHelper()
         db = FavoriteManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.db = nil
        self.favHelper = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFavoriteHelper() {
        
        let element = TvViewDataElement(titleTvShow: "MR Robot", releaseDate: "2015/10/04", description: "the best series ever", urlImage: "url..", isFavorite: false, genres: ["hacker","drama"])
        let favButton = UIButton()
        
        db.deleteAll()
        
        favHelper.validation(show: element, isFavorite: false, isFromDatabase: false, button: favButton)
        XCTAssertTrue(db.getCurrentFavorite(title: element.titleTvShow) != nil)
        
        favHelper.validation(show: element, isFavorite: true, isFromDatabase: false, button: favButton)
        XCTAssertTrue(db.getCurrentFavorite(title: element.titleTvShow) == nil)
    }

    func testDateFormated() {
        let date: String = "2015-10-04"
        
        let formatedDate = date.dateFormated()
        
        XCTAssertTrue(formatedDate.elementsEqual("10/04/2015") , "date is not formated as well")
    }
    
    func testMockService() {
        let fileUrl = Bundle.main.url(forResource: "tvShows.json", withExtension: nil)!
        let jsonData = try! Data(contentsOf: fileUrl)
        
        if let array = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: Any]] {
            assert(TvViewDataElement.parseJsonObjectToElement(jsonObject: array).count > 0)
            return
        }
        assertionFailure()
    }
}
