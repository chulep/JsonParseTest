//
//  SearchPresenter.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class SearchPresenter: SearchPresenterType {

    var result: UnsplashModel?
    let networkFetcher: NetworkFetcher
    
    //MARK: - Init
    
    init(networkFetcher: NetworkFetcher) {
        self.networkFetcher = networkFetcher
    }
    
    //MARK: - Methods
    
    func getDownloadData(searchText: String, completion: @escaping (Result<(), Error>) -> Void) {
        networkFetcher.getModel(searchText: searchText) { result in
            switch result {
            case .success(let data):
                self.result = data
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createPhotoCellPresenter(indexPath: IndexPath) -> PhotoCellPresenterType? {
        guard let result = result?.results[indexPath.row] else { return nil }
        let cellPresenter = PhotoCellPresenter(result: result, networkFetcher: networkFetcher)
        return cellPresenter
    }
    
}
