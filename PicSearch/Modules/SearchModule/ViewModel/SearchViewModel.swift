//
//  SearchViewModel.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

final class SearchViewModel: SearchViewModelType {

    var result: [DomainResultModel]?
    var isLoading = false
    
    private let repository: RepositoryType
    private var searchText: String?
    private var totalCell: Int?
    private var page = 1
    
    //MARK: - Init
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    //MARK: - Get Data
    
    func getDownloadData(searchText: String, completion: @escaping (Result<(), NetworkError>) -> Void) {
        self.searchText = searchText
        result = nil
        page = 1
        
        repository.getRemoteData(searchText: searchText) { result in
            switch result {
            case .success(let data):
                self.result = data?.results
                self.totalCell = data?.total
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDownloadDataNextPage(completion: @escaping (Result<(), NetworkError>) -> Void) {
        isLoading = false
        if totalCell != result?.count {
            isLoading = true
            guard let searchText = searchText else { return }
            page += 1
            
            repository.getRemoteData(searchText: searchText, page: page) { result in
                switch result {
                case .success(let data):
                    self.result! += data!
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Create Child ViewModel
    
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
