//
//  GenerateImageTestUnitTests.swift
//  GenerateImageTestUnitTests
//
//  Created by Anton  on 26.05.2023.
//

import XCTest
@testable import GenerateImageTest
import CoreData

final class GenerateImageStorageTest: XCTestCase {
    
    var sut: GenerateImageStorageUnderTest!

    override func setUp() {
        super.setUp()
        sut = GenerateImageStorageUnderTest()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testAddFavouriteDuplicate() throws {
        
        //given
        let imageCount = sut.imageCount
        let storage = sut.storage
        let userQuery = sut.userQuery
        print(sut.imageCount)
        
        //when
        storage.addFavourite(Data(), userQuery: userQuery)
        storage.addFavourite(Data(), userQuery: userQuery)
        
        //then
        XCTAssertEqual(storage.fetchFavouriteImages().count, imageCount + 1)
    }
    
    class GenerateImageStorageUnderTest {
        lazy var storage = GenerateImageStorage.shared
        lazy var imageCount = storage.fetchFavouriteImages().count
        lazy var userQuery = "123"
        
    }
}

