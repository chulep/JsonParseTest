//
//  ModuleBuilder.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 13.11.2022.
//

import UIKit

final class ModuleBuilder {
    
    static func createSearchModule() -> UIViewController {
        let repository = Repository()
        let viewModel = SearchViewModel(repository: repository)
        let viewController = SearchViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
    
    static func createFavoriteModule() -> UIViewController {
        let repository = Repository()
        let viewModel = FavoriteViewModel(repository: repository)
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
