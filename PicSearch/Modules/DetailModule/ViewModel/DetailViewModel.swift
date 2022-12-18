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
    var isFavorite: Bool
    
    private var detail: DomainResultModel?
    private var repository: RepositoryType?
    
    //MARK: - Init
    
    required init(detailData: DomainResultModel, repository: RepositoryType) {
        self.repository = repository
        self.url = detailData.imageUrlFull
        self.name = NameHelper.detailAuthor(name: detailData.name)
        self.description = NameHelper.detailDescription(text: detailData.description)
        self.date = NameHelper.detailDate(text: detailData.date)
        self.detail = detailData
        self.isFavorite = detail?.isFavorite ?? false
        self.checkFavorite()
    }
    
    //MARK: - Get Data
    
    func getImage(completion: @escaping (Data?) -> Void) {
        repository?.getRemoteImage(url: url, completion: completion)
    }
    
    func saveFavorite(completion: @escaping (CoreDataError?) -> Void) {
        if isFavorite == false {
            repository?.saveLocalFavorite(data: detail, completion: completion)
        } else {
            repository?.deleteLocalFavorite(data: detail, completion: completion)
        }
        isFavorite = !isFavorite
    }
    
    //MARK: - Support Methods
    
    private func checkFavorite() {
        repository?.getLocalData { [weak self] result in
            switch result {
                
            case .success(let data):
                guard let data = data else { return }
                for i in data {
                    if i.id == self?.detail?.id ?? "" { self?.isFavorite = true }
                }
                
            case .failure(_):
                break
            }
        }
    }
    
}
