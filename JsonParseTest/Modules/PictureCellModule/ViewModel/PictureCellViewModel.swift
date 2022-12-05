//
//  PhotoCellPresenter.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class PictureCellViewModel: PictureCellViewModelType {
    
    var result: DomainModel
    let repository: RepositoryType?
    
    //MARK: - init
    
    required init(result: DomainModel, repository: RepositoryType?) {
        self.result = result
        self.repository = repository
    }
    
    //MARK: - Methods
    
    func getDownloadImage(completion: @escaping (Data?) -> Void) {
        repository?.getImageNetwork(url: result.imageUrlSmall, completion: completion)
    }
    
}
