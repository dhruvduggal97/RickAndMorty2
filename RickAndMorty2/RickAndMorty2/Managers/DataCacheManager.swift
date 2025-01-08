//
//  DataCacheManager.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation


//Dependency Injection for decoupling files to be able to test
protocol DataCacheManaging {
    func save(key: String, data: Data)
    func retrieve(key: String) -> Data?
    func clear()
}

class DataCacheManager : DataCacheManaging {
    
    private let cache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024)
    
    func save(key: String, data: Data) {
        guard let url = URL(string: key) else {
            return
        }
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: data.count, textEncodingName: nil)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }
    func retrieve(key: String) -> Data? {
        guard let url = URL(string: key), let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) else {
            return nil
        }
        return cachedResponse.data
    }
    func clear() {
        cache.removeAllCachedResponses()
    }
}
