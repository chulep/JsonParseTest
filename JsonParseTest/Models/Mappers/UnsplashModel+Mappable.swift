//
//  NetworkModel+Mappable.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 29.11.2022.
//

import Foundation

extension Results {
    
    var domain: DomainModel {
        DomainModel(id: id, name: user?.username, date: created_at, description: description, imageData: nil, imageUrlFull: urls.full, imageUrlSmall: urls.small)
    }
}
