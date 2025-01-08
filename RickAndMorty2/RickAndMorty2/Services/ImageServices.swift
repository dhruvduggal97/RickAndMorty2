//
//  ImageServices.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation
import UIKit

protocol ImageServicing {
    func getImage(urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
}

class ImageServices : ImageServicing {
    private let dataManager : APIDataManaging
    
    init(dataManager: APIDataManaging) {
        self.dataManager = dataManager
    }
    
    func getImage(urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
        dataManager.getAllData(urlString: urlString, type: Data.self) { result in
            switch result {
            case .success(let data):
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(downloadedImage))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
