//
//  DetailPresenter.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 27.11.2022.
//

import Foundation

protocol DetailPresenterType {
    var name: String { get }
    var description: String { get }
    var date: String { get }
    func getImage(completion: @escaping (Data?) -> Void)
}

class DetailPresenter: DetailPresenterType {
    
    var name: String
    var description: String
    var date: String
    private var url: String
    
    var networkFetcher: NetworkFetcher?
    
    //MARK: - Init
    
    init(networkFetcher: NetworkFetcher, result: Results) {
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
