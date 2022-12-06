//
//  ErorrsHelper.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 06.12.2022.
//

import Foundation

enum NetworkError: String, Error {
    case uploadedFailed = "загрузки сетевых данных"
    case nothingFound = "Ничего не найдено\nУкажите другое название"
    case parseFailed = "открытия сетевыых данных"
}

enum CoreDataError: String, Error {
    case fetchFailed = "загрузки локальных данных"
    case parseFailed = "открытия локальных данных"
    case deleteFailed = "удаления из избранного"
    case saveFailed = "добавления в избранное"
}
