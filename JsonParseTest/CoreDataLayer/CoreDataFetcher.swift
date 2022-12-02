//
//  CoreDataFetcher.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 30.11.2022.
//

import CoreData

class CoreDataFetcher {
    
    func getData(completion: @escaping (Result<[DomainModel]?, Error>) -> Void) {
        CoreDataManager.execute.getDataT { (result: Result<[SavePicture]?, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data?.map { $0.domain }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
