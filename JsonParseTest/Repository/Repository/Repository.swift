//
//  Repository.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import Foundation

final class Repository: RepositoryType {
    
    //MARK: - Network
    
    func getRemoteData(searchText: String, completion: @escaping (Result<[DomainModel]?, Error>) -> Void) {
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
    
    func getRemoteImage(url: String?, completion: @escaping (Data?) -> Void) {
        guard let urlString = url,
        let url = URL(string: urlString) else { return completion(nil) }
        
        NetworkManager.execute.getImageTask(url: url, completion: completion)
    }
    
    //MARK: - CoreData
    
    func getLocalData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void) {
        CoreDataManager.execute.getDataTask { (result: Result<[SavePicture]?, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data?.map { $0.domain }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveLocalFavorite(data: DomainModel?) {
        CoreDataManager.execute.saveDataTask(data: data)
    }
    
    func deleteLocalFavorite(data: DomainModel?) {
        CoreDataManager.execute.deleteDataTask(data: data)
    }
    
    
}
