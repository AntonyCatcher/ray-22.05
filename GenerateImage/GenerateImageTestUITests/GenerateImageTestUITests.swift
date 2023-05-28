//
//  GenerateImageTestUITests.swift
//  GenerateImageTestUITests
//
//  Created by Anton  on 26.05.2023.
//

import XCTest

final class GenerateImageTestUITests: XCTestCase {
    
    func testIncludeUIElements() {
        //given
        let app = XCUIApplication()
        //when
        app.launch()
        //then
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.searchFields["Введите запрос"]/*[[".otherElements[\"searchBar\"].searchFields[\"Введите запрос\"]",".searchFields[\"Введите запрос\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app.descendants(matching: .image).matching(identifier: "imageView").element.exists)
        XCTAssertTrue(app.descendants(matching: .button).matching(identifier: "generateButton").element.exists)
    }
}

