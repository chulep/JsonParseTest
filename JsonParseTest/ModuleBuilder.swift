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
        let coreDataManager = CoreDataManager()
        let viewModel = FavoriteViewModel(coreDataManager: coreDataManager)
        let viewController = FavoriteViewController(viewModel: viewModel)
        return viewController
    }

}
