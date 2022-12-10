//
//  RepositoryType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

protocol RepositoryType {
    func getRemoteData(searchText: String, page: Int, completion: @escaping (Result<[DomainResultModel]?, NetworkError>) -> Void)
    func getRemoteData(searchText: String, completion: @escaping (Result<DomainModel?, NetworkError>) -> Void)
    func getRemoteImage(url: String?, completion: @escaping (Data?) -> Void)
    func getLocalData(completion: @escaping (Result<[DomainResultModel]?, CoreDataError>) -> Void)
    func saveLocalFavorite(data: DomainResultModel?, completion: @escaping (CoreDataError?) -> Void)
    func deleteLocalFavorite(data: DomainResultModel?, completion: @escaping (CoreDataError?) -> Void)
}
