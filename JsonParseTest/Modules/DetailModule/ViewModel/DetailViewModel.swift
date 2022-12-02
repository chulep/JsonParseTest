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
    private var networkFetcher: NetworkFetcher?
    private let coreData = CoreDataManager()
    
    //MARK: - Init
    
    required init(networkFetcher: NetworkFetcher, result: DomainModel) {
        self.networkFetcher = networkFetcher
        self.url = result.imageUrlFull
        self.name = "Name: " + (result.name ?? "-")
        self.description = "Description: " + (result.description ?? "-")
        self.date = "Date: " + (result.date ?? "-")
        self.detail = result
        self.favorite = detail?.favorite ?? false
    }
    
    //MARK: - Methods
    
    func getImage(completion: @escaping (Data?) -> Void) {
        networkFetcher?.getImage(url: url, completion: completion)
    }
    
    func saveFavorite() {
        if favorite == false {
            coreData.saveData(id: detail?.id, urlFull: detail?.imageUrlFull, urlSmall: detail?.imageUrlSmall, name: name, description: description, date: date)
        } else {
            coreData.deleteData(id: detail?.id)
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
    
    private func isFavorite() {
        coreData.getData { reault in
            switch reault {
                
            case .success(let data):
                for i in data.map({ $0.domain }) {
                    if i.id == self.detail?.id ?? "" { self.favorite = true }
                }
                
            case .failure(_):
                break
            }
        }
    }
    
}
