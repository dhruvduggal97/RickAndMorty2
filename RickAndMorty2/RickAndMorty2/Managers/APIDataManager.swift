//
//  APIDataManager.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation

protocol APIDataManaging {
    func getAllData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Result<T?,Error>) -> Void)
}

class APIDataManager : APIDataManaging {
    
    private let cacheManager : DataCacheManaging
    
    init(cacheManager: DataCacheManaging) {
        self.cacheManager = cacheManager
    }
    
    func getAllData<T>(urlString: String, type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            return
        }
        let cacheKey = url.absoluteString
        if let cachedData = cacheManager.retrieve(key: cacheKey) {
            handleData(data: cachedData, type: type, completion: completion)
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            self?.handleData(data: data, type: type, completion: completion)
        }
        
        task.resume()
    }
    
    private func handleData<T: Decodable>(data: Data, type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        if type == Data.self {
            DispatchQueue.main.async {
                completion(.success(data as? T))
            }
        }
        else {
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(type.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(apiResponse))
                }
            }
            catch {
                print("Error getting Models to match")
                completion(.failure(error))
            }
        }
    }
    
}
