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
    func createPhotoCellViewModel(indexPath: IndexPath) -> PictureCellViewModelType?
    func createDetailViewModel(indexPath: IndexPath) -> DetailViewModelType?
}
