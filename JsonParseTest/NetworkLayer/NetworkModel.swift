//
//  Model.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.11.2022.
//

import Foundation

struct NetworkModel: Codable {
    let total: Int
    let results: [Results]
}

struct Results: Codable {
    let id: String
    let created_at: String
    let description: String?
    let user: User?
    let urls: [Urls.RawValue: String]
}

struct User: Codable {
    let username: String?
    let name: String?
    let instagram_username: String?
}

enum Urls: String {
    case full
    case regular
    case small
}
