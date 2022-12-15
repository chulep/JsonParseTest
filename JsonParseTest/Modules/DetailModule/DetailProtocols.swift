//
//  DetailViewControllerType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

protocol DetailViewModelType {
    init(detailData: DomainResultModel, repository: RepositoryType)
    var name: String { get }
    var description: String { get }
    var date: String { get }
    var url: String? { get }
    var isFavorite: Bool { get set }
    func getImage(completion: @escaping (Data?) -> Void)
    func saveFavorite(completion: @escaping (CoreDataError?) -> Void)
}

protocol DetailViewControllerType {
    init(viewModel: DetailViewModelType?)
}
