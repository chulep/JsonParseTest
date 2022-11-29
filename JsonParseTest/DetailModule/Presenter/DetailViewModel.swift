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
    var url: String
    
    private var networkFetcher: NetworkFetcher?
    
    //MARK: - Init
    
    required init(networkFetcher: NetworkFetcher, result: Results) {
        self.networkFetcher = networkFetcher
        self.url = result.urls.full
        self.name = "Name: " + (result.user?.username ?? "")
        self.description = "Description: " + (result.description ?? "")
        self.date = "Date: " + (result.created_at)
    }
    
    //MARK: - Methods
    
    func getImage(completion: @escaping (Data?) -> Void) {
        networkFetcher?.getImage(url: url, completion: completion)
    }
}
