//
//  SearchProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

protocol SearchViewModelType {
    var result: [DomainResultModel]? { get set }
    var isLoading: Bool { get set }
    func getDownloadData(searchText: String, completion: @escaping (Result<(), NetworkError>) -> Void)
    func getDownloadDataNetxPage(completion: @escaping (Result<(), NetworkError>) -> Void)
    func createPhotoCellViewModel(indexPath: IndexPath) -> PictureCellViewModelType?
    func createDetailViewModel(indexPath: IndexPath) -> DetailViewModelType?
}

protocol SearchViewControllerType {
    init(viewModel: SearchViewModelType)
}
