//
//  RepositoryType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

protocol RepositoryType {
    func getRemoteData(searchText: String, completion: @escaping (Result<[DomainModel]?, Error>) -> Void)
    func getRemoteImage(url: String?, completion: @escaping (Data?) -> Void)
    func getLocalData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void)
    func saveLocalFavorite(data: DomainModel?)
    func deleteLocalFavorite(data: DomainModel?)
}
