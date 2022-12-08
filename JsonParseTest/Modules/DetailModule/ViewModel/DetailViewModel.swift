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
    private var repository: RepositoryType?
    
    //MARK: - Init
    
    required init(detailData: DomainModel, repository: RepositoryType) {
        self.repository = repository
        self.url = detailData.imageUrlFull
        self.name = NameHelper.author(name: detailData.name)
        self.description = NameHelper.description(text: detailData.description)
        self.date = NameHelper.date(text: detailData.date)
        self.detail = detailData
        self.favorite = detail?.favorite ?? false
        self.checkFavorite()
    }
    
    //MARK: - Methods
    
    func getImage(completion: @escaping (Data?) -> Void) {
        repository?.getRemoteImage(url: url, completion: completion)
    }
    
    func saveFavorite(completion: @escaping (CoreDataError?) -> Void) {
        if favorite == false {
            repository?.saveLocalFavorite(data: detail, completion: completion)
        } else {
            repository?.deleteLocalFavorite(data: detail, completion: completion)
        }
        favorite = !favorite
    }
    
    private func checkFavorite() {
        repository?.getLocalData { result in
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
