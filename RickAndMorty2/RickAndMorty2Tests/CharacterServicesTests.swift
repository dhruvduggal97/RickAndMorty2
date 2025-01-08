//
//  CharacterServicesTests.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//
import XCTest
@testable import RickAndMorty2

class CharacterServicesTests: XCTestCase {
    var mockAPIManager: MockAPIDataManager!
    var service: CharacterServices!

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIDataManager()
        service = CharacterServices(dataManager: mockAPIManager)
    }

    override func tearDown() {
        mockAPIManager = nil
        service = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() {
        // Arrange
        let mockJSON = """
        {
            "info": {
                "count": 1,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": [
                {
                    "id": 1,
                    "name": "Rick Sanchez",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {
                        "name": "Earth",
                        "url": ""
                    },
                    "location": {
                        "name": "Citadel of Ricks",
                        "url": ""
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    "episode": [],
                    "url": "",
                    "created": ""
                }
            ]
        }
        """.data(using: .utf8)
        mockAPIManager.mockResponse = mockJSON

        let expectation = XCTestExpectation(description: "Fetch characters")

        // Act
        service.getAllCharacters(urlString: "https://mockapi.com") { result in
            // Assert
            switch result {
            case .success(let responseModel):
                XCTAssertNotNil(responseModel)
                XCTAssertEqual(responseModel?.results.count, 1)
                XCTAssertEqual(responseModel?.results.first?.name, "Rick Sanchez")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCharactersFailure() {
        // Arrange
        mockAPIManager.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Fetch characters")

        // Act
        service.getAllCharacters(urlString: "https://mockapi.com") { result in
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

class MockAPIDataManager: APIDataManaging {
    var shouldReturnError = false
    var mockResponse: Data?

    func getAllData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        } else if let mockResponse = mockResponse {
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

