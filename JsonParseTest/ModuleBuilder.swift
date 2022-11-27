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
        let presenter = SearchPresenter(networkFetcher: networkFetcher)
        let viewController = SearchViewController(presenter: presenter)
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = "Search"
        navController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        return navController
    }

}
