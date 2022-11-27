//
//  SearchProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

protocol SearchPresenterType {
    var result: UnsplashModel? { get set }
    func getDownloadData(searchText: String, completion: @escaping (Result<(), Error>) -> Void)
    func createPhotoCellPresenter(indexPath: IndexPath) -> PhotoCellPresenterType?
    func createDetailPresenter(indexPath: IndexPath) -> DetailPresenterType?
}

protocol PhotoCellPresenterType {
    init(result: Results, networkFetcher: NetworkFetcher)
    func getDownloadImage(completion: @escaping (Data?) -> Void)
}
