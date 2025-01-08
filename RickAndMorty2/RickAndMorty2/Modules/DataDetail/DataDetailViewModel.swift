//
//  DataDetailViewModel.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//


import Foundation

class DataDetailViewModel {
    
    private let character : Character
    
    init(character: Character) {
        self.character = character
    }
    
    func getCharacterName() -> String {
        return character.name
    }
    
    func getCharacterLocation() -> String {
        return character.location.name

    }
    
    func getCharacterStatus() -> String {
        return character.status

    }
    
    func getCharacterImageString() -> String {
        return character.image

    }
}
