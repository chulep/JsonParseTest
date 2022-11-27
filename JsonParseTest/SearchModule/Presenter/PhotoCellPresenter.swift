//
//  PhotoCellPresenter.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class PhotoCellPresenter: PhotoCellPresenterType {
    
    let result: Results
    let networkfetcher: NetworkFetcher
    
    //MARK: - init
    
    required init(result: Results, networkFetcher: NetworkFetcher) {
        self.result = result
        self.networkfetcher = networkFetcher
    }
    
    //MARK: - Methods
    
    func getDownloadImage(completion: @escaping (Data?) -> Void) {
        networkfetcher.getImage(url: result.urls.small, completion: completion)
    }
    
}
