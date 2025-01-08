//
//  ImageServiceTests.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import XCTest
@testable import RickAndMorty2
class ImageServicesTests: XCTestCase {
    var service: ImageServices!
    var mockAPIManager: MockAPIDataManagerImages!

    override func setUp() {
        super.setUp()
        // Initialize mocks and the service
        mockAPIManager = MockAPIDataManagerImages()
        service = ImageServices(dataManager: mockAPIManager)
    }

    override func tearDown() {
        mockAPIManager = nil
        service = nil
        super.tearDown()
    }

    func testFetchImageSuccess() {
        // Arrange
        let validImageData = UIImage(named: "test_image")!.pngData() // Replace with a valid image in your tests
        mockAPIManager.mockResponse = validImageData

        let expectation = XCTestExpectation(description: "Fetch image")

        // Act
        service.getImage(urlString: "https://mockapi.com/image") { result in
            // Assert
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchImageFailure() {
        // Arrange
        mockAPIManager.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Fetch image failure")

        // Act
        service.getImage(urlString: "https://mockapi.com/image") { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchImageInvalidData() {
        // Arrange
        let invalidData = "invalid data".data(using: .utf8)
        mockAPIManager.mockResponse = invalidData

        let expectation = XCTestExpectation(description: "Fetch image with invalid data")

        // Act
        service.getImage(urlString: "https://mockapi.com/image") { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockAPIDataManagerImages: APIDataManaging {
    var shouldReturnError = false
    var mockResponse: Data?

    func getAllData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        } else if let mockResponse = mockResponse {
            if type == Data.self {
                completion(.success(mockResponse as? T))
            } else {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(type, from: mockResponse)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
