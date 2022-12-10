//
//  SearchViewModel.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class SearchViewModel: SearchViewModelType {

    var result: [DomainResultModel]?
    var isLoading = false
    
    private var totalCell: Int?
    private let repository: RepositoryType
    private var page = 1
    private var searchText: String?
    
    //MARK: - Init
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    //MARK: - Methods
    
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
    
    func getDownloadDataNetxPage(completion: @escaping (Result<(), NetworkError>) -> Void) {
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
        print(isLoading)
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
