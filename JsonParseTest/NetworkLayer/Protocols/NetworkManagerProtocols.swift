//
//  NetworkManagerProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

protocol NetworkManagerType {
    func getModelTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T?, NetworkError>) -> Void)
    func getImageTask(url: URL, completion: @escaping (Data?) -> Void)
}
