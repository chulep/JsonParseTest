//
//  Repository.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

protocol RepositoryType {
    func getDataNetwork(searchText: String, completion: @escaping (Result<[DomainModel]?, Error>) -> Void)
    func getImageNetwork(url: String?, completion: @escaping (Data?) -> Void)
    func getCoreData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void)
    func saveFavoriteCoreData(data: DomainModel?)
    func deleteFavoriteCoreData(data: DomainModel?)
}

final class Repository: RepositoryType {
    
    //MARK: - Network
    
    func getDataNetwork(searchText: String, completion: @escaping (Result<[DomainModel]?, Error>) -> Void) {
        let request = createRequest(searchText: searchText)
        
        NetworkManager.execute.getModelTask(request: request) { (result: Result<UnsplashModel?, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data?.results.map { $0.domain } ))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImageNetwork(url: String?, completion: @escaping (Data?) -> Void) {
        guard let urlString = url,
        let url = URL(string: urlString) else { return completion(nil) }
        
        NetworkManager.execute.getImageTask(url: url, completion: completion)
    }
    
    //MARK: - CoreData
    
    func getCoreData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void) {
        CoreDataManager.execute.getData { (result: Result<[SavePicture]?, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data?.map { $0.domain }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveFavoriteCoreData(data: DomainModel?) {
        CoreDataManager.execute.saveData(data: data)
    }
    
    func deleteFavoriteCoreData(data: DomainModel?) {
        CoreDataManager.execute.deleteData(data: data)
    }
    
    
}
