import XCTest
@testable import RickAndMorty2// Replace with your app's module name

class APIDataManagerTests: XCTestCase {
    var dataManager: APIDataManager!
    var cacheManager: DataCacheManager!

    override func setUp() {
        super.setUp()

        // Set up mock URLProtocol
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self] // Register MockURLProtocol
        let session = URLSession(configuration: config)

        cacheManager = DataCacheManager()
        dataManager = APIDataManager(cacheManager: cacheManager)
        dataManager.session = session // Use session with MockURLProtocol
    }

    override func tearDown() {
        dataManager = nil
        cacheManager = nil
        super.tearDown()
    }

    func testSuccessfulDecoding() {
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
        MockURLProtocol.mockResponse = (
            mockJSON,
            HTTPURLResponse(url: URL(string: "https://mockapi.com")!, statusCode: 200, httpVersion: nil, headerFields: nil),
            nil
        )

        let expectation = XCTestExpectation(description: "Decoding JSON")

        // Act
        dataManager.getAllData(urlString: "https://mockapi.com", type: APIResponseModel.self) { result in
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

    func testNetworkError() {
        // Arrange
        MockURLProtocol.mockResponse = (nil, nil, NSError(domain: "network", code: -1, userInfo: nil))

        let expectation = XCTestExpectation(description: "Network error")

        // Act
        dataManager.getAllData(urlString: "https://mockapi.com", type: APIResponseModel.self) { result in
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

    func testRawDataReturn() {
        // Arrange
        let rawData = "Raw data".data(using: .utf8)
        MockURLProtocol.mockResponse = (
            rawData,
            HTTPURLResponse(url: URL(string: "https://mockapi.com")!, statusCode: 200, httpVersion: nil, headerFields: nil),
            nil
        )

        let expectation = XCTestExpectation(description: "Raw data")

        // Act
        dataManager.getAllData(urlString: "https://mockapi.com", type: Data.self) { result in
            // Assert
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(String(data: data!, encoding: .utf8), "Raw data")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockURLProtocol: URLProtocol {
    static var mockResponse: (Data?, URLResponse?, Error?)?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let (data, response, error) = MockURLProtocol.mockResponse {
            if let error = error {
                self.client?.urlProtocol(self, didFailWithError: error)
            } else {
                if let response = response {
                    self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                if let data = data {
                    self.client?.urlProtocol(self, didLoad: data)
                }
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
