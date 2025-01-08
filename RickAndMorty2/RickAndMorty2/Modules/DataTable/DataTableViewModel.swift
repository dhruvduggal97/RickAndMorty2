//
//  DataTableViewModel.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation

class DataTableViewModel {
    
    private let characterServices : CharacterServicing
    
    init(characterServices: CharacterServicing) {
        self.characterServices = characterServices
    }
    
    
    weak var coordinator : MainCoordinator!
    private var urlString = "https://rickandmortyapi.com/api/character"
    private var characters = [Character]()
    private var filteredCharacters = [Character]()
    private var isSearching : Bool = false
    private var debounceWorkItem : DispatchWorkItem?
    
    func getCharacterCount() -> Int {
        return isSearching ? filteredCharacters.count : characters.count
    }
    
    func getCurrentCharacter(index: Int) -> Character {
        return isSearching ? filteredCharacters[index] : characters[index]
    }
    
    func getAllCharacters(completion: @escaping () -> Void) {
        characterServices.getAllCharacters(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let model):
                guard let model = model else {
                    completion()
                    return
                }
                self?.characters = model.results
                self?.filteredCharacters = self?.characters ?? []
                completion()
            case .failure(_):
                print("Error in viewModel")
                completion()
            }
        }
    }
    
    func filterCharacters(query: String, completion: @escaping () -> Void) {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            if query.isEmpty {
                self?.isSearching = false
                self?.filteredCharacters = self?.characters ?? []
            }
            else {
                self?.isSearching = true
                self?.filteredCharacters = self?.characters.filter({$0.name.lowercased().contains(query.lowercased()) || $0.status.lowercased().contains(query.lowercased())}) ?? []
            }
            completion()
        }
        
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    func showDetails(character: Character) {
        coordinator.showDetails(character: character)
    }
    

}
