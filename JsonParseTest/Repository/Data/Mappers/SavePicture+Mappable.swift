//
//  CoreDataModel+Mappable.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 30.11.2022.
//

import Foundation

extension SavePicture {
    
    var domain: DomainResultModel {
        DomainResultModel(id: idSave, name: nameSave, date: dateSave, description: descriptionSave, imageUrlFull: urlFullSave, imageUrlSmall: urlSmallSave, isFavorite: true)
    }
}
