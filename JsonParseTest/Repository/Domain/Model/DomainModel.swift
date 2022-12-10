//
//  Model.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

struct DomainModel {
    let total: Int
    let results: [DomainResultModel]?
}

struct DomainResultModel {
    let id: String?
    let name: String?
    let date: String?
    let description: String?
    let imageUrlFull: String?
    let imageUrlSmall: String?
    var favorite: Bool
}
