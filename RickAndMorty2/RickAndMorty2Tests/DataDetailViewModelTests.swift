//
//  DataDetailViewModelTests.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import XCTest
@testable import RickAndMorty2

class DataDetailViewModelTests: XCTestCase {
    var viewModel: DataDetailViewModel!
    var character: Character!

    override func setUp() {
        super.setUp()
        // Mock character data
        character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Location(name: "Earth", url: ""),
            location: Location(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: ""
        )
        // Initialize the ViewModel
        viewModel = DataDetailViewModel(character: character)
    }

    override func tearDown() {
        // Clean up
        viewModel = nil
        character = nil
        super.tearDown()
    }

    func testGetCharacterName() {
        // Assert that the character name is correctly returned
        XCTAssertEqual(viewModel.getCharacterName(), "Rick Sanchez")
    }

    func testGetCharacterLocation() {
        // Assert that the character location is correctly returned
        XCTAssertEqual(viewModel.getCharacterLocation(), "Citadel of Ricks")
    }

    func testGetCharacterStatus() {
        // Assert that the character status is correctly returned
        XCTAssertEqual(viewModel.getCharacterStatus(), "Alive")
    }

    func testGetCharacterImageString() {
        // Assert that the character image URL is correctly returned
        XCTAssertEqual(viewModel.getCharacterImageString(), "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
    }
}
