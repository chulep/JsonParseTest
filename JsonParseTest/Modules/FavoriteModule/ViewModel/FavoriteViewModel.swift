//
//  FavoriteViewModel.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

final class FavoriteViewModel: FavoriteViewModelType {
    
    var pictureArray: [DomainModel]?
    
    private let repository: RepositoryType
    
    //MARK: - Init
    
    required init(repository: RepositoryType) {
        self.repository = repository
    }
    
    //MARK: - Methods
    
    func getData(completion: @escaping (Result<(), Error>) -> Void) {
        repository.getLocalData { [weak self] result in
            switch result {
            case .success(let data):
                self?.pictureArray = data
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createCellViewModel(indexPath: IndexPath) -> PictureCellViewModelType? {
        guard let data = pictureArray?[indexPath.row] else { return nil }
        return PictureCellViewModel(result: data, repository: repository)
    }
    
}
