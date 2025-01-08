import XCTest
@testable import RickAndMorty2

class DataTableViewModelTests: XCTestCase {
    var viewModel: DataTableViewModel!
    var mockService: MockCharacterServices!
    var mockCoordinator: MockCoordinator!

    override func setUp() {
        super.setUp()
        // Initialize mocks
        mockService = MockCharacterServices()
        mockCoordinator = MockCoordinator()
        // Inject the coordinator directly into the ViewModel
        viewModel = DataTableViewModel(characterServices: mockService)
        viewModel.coordinator = mockCoordinator
    }

    override func tearDown() {
        // Clean up
        viewModel = nil
        mockService = nil
        mockCoordinator = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() {
        // Arrange
        mockService.mockCharacters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        ]

        let expectation = XCTestExpectation(description: "Fetch characters")

        // Act
        viewModel.getAllCharacters {
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(self.viewModel.getCharacterCount(), 2)
    }

    func testFilterCharacters() {
        // Arrange
        mockService.mockCharacters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        ]
        viewModel.getAllCharacters { }

        let expectation = XCTestExpectation(description: "Filter characters")

        // Act
        viewModel.filterCharacters(query: "Rick") {
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(self.viewModel.getCharacterCount(), 1)
        XCTAssertEqual(self.viewModel.getCurrentCharacter(index: 0).name, "Rick")
    }

    func testShowDetails() {
        // Arrange
        let character = Character(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")

        // Act
        viewModel.showDetails(character: character)

        // Assert
        XCTAssertTrue(mockCoordinator.didShowDetails)
        XCTAssertEqual(mockCoordinator.passedCharacter?.name, "Rick")
    }
}

class MockCharacterServices: CharacterServicing {
    var shouldReturnError = false
    var mockCharacters: [Character] = []

    func getAllCharacters(urlString: String, completion: @escaping (Result<APIResponseModel?, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        } else {
            let response = APIResponseModel(info: Info(count: mockCharacters.count, pages: 1, next: nil, prev: nil), results: mockCharacters)
            completion(.success(response))
        }
    }
}

class MockCoordinator: MainCoordinating {
    var navigationController: UINavigationController = UINavigationController()
    var didShowDetails = false
    var passedCharacter: Character?

    func start() {}
    func showDetails(character: Character) {
        didShowDetails = true
        passedCharacter = character
    }
}
