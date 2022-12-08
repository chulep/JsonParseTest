//
//  RepositoryType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

protocol RepositoryType {
    func getRemoteData(searchText: String, completion: @escaping (Result<[DomainModel]?, NetworkError>) -> Void)
    func getRemoteImage(url: String?, completion: @escaping (Data?) -> Void)
    func getLocalData(completion: @escaping (Result<[DomainModel]?, CoreDataError>) -> Void)
    func saveLocalFavorite(data: DomainModel?, completion: @escaping (CoreDataError?) -> Void)
    func deleteLocalFavorite(data: DomainModel?, completion: @escaping (CoreDataError?) -> Void)
}
