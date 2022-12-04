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
    var favorite: Bool
    
    private var detail: DomainModel?
    private var networkFetcher: NetworkFetcherType?
    private var coreData: CoreDataFetcherType?
    
    //MARK: - Init
    
    required init(result: DomainModel, networkFetcher: NetworkFetcherType, coreDataFetcher: CoreDataFetcherType) {
        self.networkFetcher = networkFetcher
        self.coreData = coreDataFetcher
        self.url = result.imageUrlFull
        self.name = "Name: " + (result.name ?? "-")
        self.description = "Description: " + (result.description ?? "-")
        self.date = "Date: " + (result.date ?? "-")
        self.detail = result
        self.favorite = detail?.favorite ?? false
        self.checkFavorite()
    }
    
    //MARK: - Methods
    
    func getImage(completion: @escaping (Data?) -> Void) {
        networkFetcher?.getImage(url: url, completion: completion)
    }
    
    func saveFavorite() {
        if favorite == false {
            coreData?.saveData(data: detail)
        } else {
            coreData?.deleteData(data: detail)
        }
        
        favorite = !favorite
    }
    
    func barButtonImageName() -> String {
        switch favorite {
        case true:
            return "heart.fill"
        case false:
            return "heart"
        }
    }
    
    private func checkFavorite() {
        coreData?.getData { result in
            switch result {
                
            case .success(let data):
                guard let data = data else { return }
                for i in data {
                    if i.id == self.detail?.id ?? "" { self.favorite = true }
                }
                
            case .failure(_):
                break
            }
        }
    }
    
}
