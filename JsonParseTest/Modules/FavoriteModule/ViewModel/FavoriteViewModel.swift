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
    private let networkFetcher: NetworkFetcher
    
    //MARK: - Init
    
    required init(coreDataManager: CoreDataManager, networkFetcher: NetworkFetcher) {
        self.coreDataManager = coreDataManager
        self.networkFetcher = networkFetcher
    }
    
    //MARK: - Methods
    
    func getData(completion: @escaping (Result<(), Error>) -> Void) {
        coreDataManager.getData { [weak self] result in
            switch result {
            case .success(let data):
                self?.pictureArray = data.map { $0.domain }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createCellViewModel(indexPath: IndexPath) -> PhotoCellViewModelType? {
        guard let data = pictureArray?[indexPath.row] else { return nil }
        return PhotoCellViewModel(result: data, networkFetcher: networkFetcher)
    }
    
}
