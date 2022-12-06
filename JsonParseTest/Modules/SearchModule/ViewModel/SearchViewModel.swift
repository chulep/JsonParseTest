//
//  SearchViewModel.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class SearchViewModel: SearchViewModelType {

    var result: [DomainModel]?
    let repository: RepositoryType
    
    //MARK: - Init
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    //MARK: - Methods
    
    func getDownloadData(searchText: String, completion: @escaping (Result<(), NetworkError>) -> Void) {
        repository.getRemoteData(searchText: searchText) { result in
            switch result {
            case .success(let data):
                self.result = data
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createPhotoCellViewModel(indexPath: IndexPath) -> PictureCellViewModelType? {
        guard let result = result?[indexPath.row] else { return nil }
        let cellViewModel = PictureCellViewModel(result: result, repository: repository)
        return cellViewModel
    }
    
    func createDetailViewModel(indexPath: IndexPath) -> DetailViewModelType? {
        guard let result = result?[indexPath.row] else { return nil }
        let detailViewModel = DetailViewModel(detailData: result, repository: repository)
        return detailViewModel
    }
    
}
