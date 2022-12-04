//
//  CoreDataFetcher.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 30.11.2022.
//

import CoreData

protocol CoreDataFetcherType {
    func getData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void)
    func saveData(data: DomainModel?)
    func deleteData(data: DomainModel?)
}

class CoreDataFetcher: CoreDataFetcherType {
    
    func getData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void) {
        CoreDataManager.execute.getData { (result: Result<[SavePicture]?, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data?.map { $0.domain }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveData(data: DomainModel?) {
        CoreDataManager.execute.saveData(data: data)
    }
    
    func deleteData(data: DomainModel?) {
        CoreDataManager.execute.deleteData(data: data)
    }
    
}
