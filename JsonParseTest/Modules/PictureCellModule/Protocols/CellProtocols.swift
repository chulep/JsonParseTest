//
//  CellProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 04.12.2022.
//

import Foundation

protocol PictureCellViewModelType {
    init(result: DomainModel, networkFetcher: NetworkFetcherType?)
    func getDownloadImage(completion: @escaping (Data?) -> Void)
}

protocol PictureCellType {
    var viewModel: PictureCellViewModelType? { get }
}
