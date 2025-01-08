//
//  DataCacheManagerTests.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import XCTest
@testable import RickAndMorty2  

class DataCacheManagerTests: XCTestCase {
    var cacheManager: DataCacheManager!

    override func setUp() {
        super.setUp()
        cacheManager = DataCacheManager()
    }

    override func tearDown() {
        cacheManager.clear() // Clear the cache after each test
        cacheManager = nil
        super.tearDown()
    }

    func testSaveAndRetrieveData() {
        // Arrange
        let key = "testKey"
        let data = "Test Data".data(using: .utf8)

        // Act
        cacheManager.save(key: key, data: data!)
        let retrievedData = cacheManager.retrieve(key: key)

        // Assert
        XCTAssertNotNil(retrievedData)
        XCTAssertEqual(retrievedData, data)
    }

    func testRetrieveNonExistentKey() {
        // Arrange
        let key = "nonExistentKey"

        // Act
        let retrievedData = cacheManager.retrieve(key: key)

        // Assert
        XCTAssertNil(retrievedData)
    }

    func testClearCache() {
        // Arrange
        let key = "testKey"
        let data = "Test Data".data(using: .utf8)
        cacheManager.save(key: key, data: data!)

        // Act
        cacheManager.clear()
        let retrievedData = cacheManager.retrieve(key: key)

        // Assert
        XCTAssertNil(retrievedData)
    }
}
