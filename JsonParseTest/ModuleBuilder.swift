//
//  ModuleBuilder.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 13.11.2022.
//

import UIKit

final class ModuleBuilder {
    
    static func createStartTabBarModule() -> UITabBarController {
        let searchVC = ModuleBuilder.createSearchModule()
        let favoriteVC = ModuleBuilder.createFavoriteModule()
        return TabBarController(viewControllers: [searchVC, favoriteVC])
    }
    
    static func createSearchModule() -> UIViewController {
        let repository = Repository()
        let viewModel = SearchViewModel(repository: repository)
        let viewController = SearchViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    static func createFavoriteModule() -> UIViewController {
        let repository = Repository()
        let viewModel = FavoriteViewModel(repository: repository)
        return FavoriteViewController(viewModel: viewModel)
    }
    
    static func createDetailModule(viewModel: DetailViewModelType?) -> UINavigationController {
        let viewController = DetailViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
}
