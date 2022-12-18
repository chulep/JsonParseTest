//
//  PhotoCellPresenter.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class PictureCellViewModel: PictureCellViewModelType {
    
    var result: DomainResultModel
    let repository: RepositoryType?
    
    //MARK: - init
    
    required init(result: DomainResultModel, repository: RepositoryType?) {
        self.result = result
        self.repository = repository
    }
    
    //MARK: - Get Data
    
    func getDownloadImage(completion: @escaping (Data?) -> Void) {
        repository?.getRemoteImage(url: result.imageUrlSmall, completion: completion)
    }
    
}
