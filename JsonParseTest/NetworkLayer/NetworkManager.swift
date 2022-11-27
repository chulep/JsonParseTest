//
//  NetworkManager.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import Foundation

class NetworkManager {
    let networkManager = NetworkManager()
    
    func getModelExecuteTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T?, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return completion(.success(nil)) }

            do {
                try completion(.success(JSONDecoder().decode(T.self, from: data)))
                print(data.count)
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getImageExecuteTask(url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil { completion(data) } else { completion(nil) }
        }.resume()
    }
    
    
}
