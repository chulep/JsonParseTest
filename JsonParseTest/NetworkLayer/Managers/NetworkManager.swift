//
//  NetworkManager.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import Foundation

class NetworkManager: NetworkManagerType {
    
    static let execute = NetworkManager()
    
    func getModelTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil { return completion(.failure(NetworkError.uploadedFailed)) }
            guard let data = data else { return completion(.failure(NetworkError.nothingFound)) }

            do {
                try completion(.success(JSONDecoder().decode(T.self, from: data)))
            } catch {
                completion(.failure(NetworkError.parseFailed))
            }
        }.resume()
    }
    
    func getImageTask(url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
        }.resume()
    }
    
    
    
}
