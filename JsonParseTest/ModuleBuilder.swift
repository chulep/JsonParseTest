//
//  ModuleBuilder.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 13.11.2022.
//

import UIKit

final class ModuleBuilder {
    
    static func createSearchModule() -> UIViewController {
        let networkFetcher = NetworkFetcher()
        let viewModel = SearchViewModel(networkFetcher: networkFetcher)
        let viewController = SearchViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
    
    static func createFavoriteModule() -> UIViewController {
        let coreDataFetcher = CoreDataFetcher()
        let networkFetcher = NetworkFetcher()
        let viewModel = FavoriteViewModel(coreDataManager: coreDataFetcher, networkFetcher: networkFetcher)
        let viewController = FavoriteViewController(viewModel: viewModel)
        return viewController
    }
    
    static func createDetailMpdule(viewModel: DetailViewModelType?) -> UINavigationController {
        let viewController = DetailViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        return navController
    }

}
