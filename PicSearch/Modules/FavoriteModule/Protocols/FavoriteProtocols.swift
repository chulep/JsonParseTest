//
//  FavoriteViewModelType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

protocol FavoriteViewModelType {
    init(repository: RepositoryType)
    var pictureArray: [DomainResultModel]? { get set }
    func getData(completion: @escaping (Result<(), CoreDataError>) -> Void)
    func createCellViewModel(indexPath: IndexPath) -> PictureCellViewModelType?
    func createDetailViewModel(indexPath: IndexPath) -> DetailViewModelType?
}

protocol FavoriteViewControllerType {
    init(viewModel: FavoriteViewModelType)
}
