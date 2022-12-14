//
//  NetworkModel+Mappable.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

extension Results {
    
    var domain: DomainResultModel {
        DomainResultModel(id: id, name: user?.username, date: created_at, description: description, imageUrlFull: urls.regular, imageUrlSmall: urls.thumb, isFavorite: false)
    }
}
