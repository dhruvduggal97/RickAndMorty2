//
//  CharacterServices.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation

protocol CharacterServicing {
    func getAllCharacters(urlString: String, completion: @escaping (Result<APIResponseModel?,Error>) -> Void)
}

class CharacterServices : CharacterServicing {
    private let dataManager : APIDataManaging
    
    init(dataManager: APIDataManaging) {
        self.dataManager = dataManager
    }
    
    func getAllCharacters(urlString: String, completion: @escaping (Result<APIResponseModel?,Error>) -> Void) {
        dataManager.getAllData(urlString: urlString, type: APIResponseModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
