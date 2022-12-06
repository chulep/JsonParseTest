//
//  NameHelper.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 06.12.2022.
//

import Foundation

struct NameHelper {
    static let searchTaskLabel = "Начните поиск\nЗдесь будет отображен результат"
    static let noFavoriteLabel = "Избранных картинок нет"
    static let seacrhTabBarName = "Поиск"
    static let favoriteTabBarName = "Избранное"
    
    static func author(name: String?) -> String {
        return "Автор: " + (name ?? "-")
    }
    
    static func description(text: String?) -> String {
        return "Описание: " + (text ?? "-")
    }
    
    static func date(text: String?) -> String {
        return "Дата: " + dateFormatter(text: text)
    }
    
    //MARK: - Support Methods
    
    private static func dateFormatter(text: String?) -> String {
        guard let text = text else { return "-" }
        let format = DateFormatter()
        format.date(from: text)
        format.dateFormat = "dd.MM.YY"
        let data = format.string(from: Date.init())
        return data
    }
}
