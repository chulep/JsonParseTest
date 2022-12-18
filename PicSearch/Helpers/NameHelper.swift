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
    static let searchAlertLabel = "Начните поиск\nЗдесь появится результат"
    
    static func detailAuthor(name: String?) -> String {
        return "Автор: " + (name ?? "-")
    }
    
    static func detailDescription(text: String?) -> String {
        return "Описание: " + (text ?? "-")
    }
    
    static func detailDate(text: String?) -> String {
        guard let text = text else { return "Дата: -" }
        
        let format = DateFormatter()
        format.date(from: text)
        format.dateFormat = "dd.MM.YY"
        let date = format.string(from: Date.init())
        return "Дата: " + date
    }
}
