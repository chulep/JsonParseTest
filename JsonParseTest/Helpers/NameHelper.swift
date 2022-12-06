//
//  NameHelper.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 06.12.2022.
//

import Foundation

struct NameHelper {
    static let noFavoriteLabel = "Избранных картинок нет"
    static let seacrhTabBarName = "Поиск"
    static let favoriteTabBarName = "Избранное"
    
    static func searchTaskLabel(resultCount: Int?) -> String {
        if resultCount == nil {
            return "Начните поиск\nЗдесь появится результат"
        } else {
            return "Ничего не найдено\nУкажите другое название"
        }
    }
    
    static func author(name: String?) -> String {
        return "Автор: " + (name ?? "-")
    }
    
    static func description(text: String?) -> String {
        return "Описание: " + (text ?? "-")
    }
    
    static func date(text: String?) -> String {
        guard let text = text else { return "Дата: -" }
        
        let format = DateFormatter()
        format.date(from: text)
        format.dateFormat = "dd.MM.YY"
        let date = format.string(from: Date.init())
        return "Дата: " + date
    }
}
