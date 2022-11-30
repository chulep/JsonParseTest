//
//  SearchProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

protocol SearchViewModelType {
    var result: [DomainModel]? { get set }
    func getDownloadData(searchText: String, completion: @escaping (Result<(), Error>) -> Void)
    func createPhotoCellPresenter(indexPath: IndexPath) -> PhotoCellViewModelType?
    func createDetailPresenter(indexPath: IndexPath) -> DetailViewModelType?
}

protocol PhotoCellViewModelType {
    init(result: DomainModel, networkFetcher: NetworkFetcher)
    func getDownloadImage(completion: @escaping (Data?) -> Void)
}
