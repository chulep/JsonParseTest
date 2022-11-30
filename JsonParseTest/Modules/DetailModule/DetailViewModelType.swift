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
    init(networkFetcher: NetworkFetcher, result: DomainModel)
    func getImage(completion: @escaping (Data?) -> Void)
}
