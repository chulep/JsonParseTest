//
//  FavoriteViewModel.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

final class FavoriteViewModel: FavoriteViewModelType {
    
    var pictureArray: [DomainModel]?
    
    private let coreDataManager: CoreDataManager
    
    //MARK: - Init
    
    required init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - Methods
    
    func getData(completion: @escaping (Result<(), Error>) -> Void) {
        coreDataManager.getData { [weak self] result in
            switch result {
            case .success(let data):
                self?.pictureArray = data
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
