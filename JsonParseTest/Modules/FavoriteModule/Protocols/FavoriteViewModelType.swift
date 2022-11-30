//
//  FavoriteViewModelType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

protocol FavoriteViewModelType {
    var pictureArray: [DomainModel]? { get set }
    init(coreDataManager: CoreDataManager)
    func getData(completion: @escaping (Result<(), Error>) -> Void)
}
