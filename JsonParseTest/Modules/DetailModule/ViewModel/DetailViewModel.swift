//
//  DetailViewModel.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

class DetailViewModel: DetailViewModelType {
    
    var name: String
    var description: String
    var date: String
    var url: String?
    
    private var networkFetcher: NetworkFetcher?
    
    //MARK: - Init
    
    required init(networkFetcher: NetworkFetcher, result: DomainModel) {
        self.networkFetcher = networkFetcher
        self.url = result.imageUrlFull
        self.name = "Name: " + (result.name ?? "")
        self.description = "Description: " + (result.description ?? "")
        self.date = "Date: " + (result.date ?? "")
    }
    
    //MARK: - Methods
    
    func getImage(completion: @escaping (Data?) -> Void) {
        networkFetcher?.getImage(url: url, completion: completion)
    }
}
