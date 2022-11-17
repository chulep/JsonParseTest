//
//  Model.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import Foundation

struct PicModel: Codable {
    let total: Int
    let results: [Results]
}

struct Results: Codable {
    let id: String
    let created_at: String
    let description: String?
    let user: User?
    let urls: Urls
}

struct User: Codable {
    let username: String?
}

struct Urls: Codable {
    let full: String
    let small: String
}
