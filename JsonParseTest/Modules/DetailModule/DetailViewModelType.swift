//
//  DetailViewModelType.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

protocol DetailViewModelType {
    var name: String { get }
    var description: String { get }
    var date: String { get }
    var url: String? { get }
    var favorite: Bool { get set } 
    init(result: DomainModel, repository: RepositoryType)
    func getImage(completion: @escaping (Data?) -> Void)
    func saveFavorite()
    func barButtonImageName() -> String
}
