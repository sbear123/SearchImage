//
//  SearchImageMainUITests.swift
//  SearchImageMainUITests
//
//  Created by 박지현 on 2021/06/29.
//

import XCTest
@testable import SearchImage

class SearchImageMainUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func testSearchTest() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText("안녕하세요.")
        let resultCell = app.cells.firstMatch
        XCTAssertTrue(resultCell.waitForExistence(timeout: 10))
    }
}
