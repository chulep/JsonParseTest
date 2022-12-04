//
//  PhotoCellPresenter.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class PictureCellViewModel: PictureCellViewModelType {
    
    var result: DomainModel
    let networkfetcher: NetworkFetcherType?
    
    //MARK: - init
    
    required init(result: DomainModel, networkFetcher: NetworkFetcherType?) {
        self.result = result
        self.networkfetcher = networkFetcher
    }
    
    //MARK: - Methods
    
    func getDownloadImage(completion: @escaping (Data?) -> Void) {
        networkfetcher?.getImage(url: result.imageUrlSmall, completion: completion)
    }
    
}
