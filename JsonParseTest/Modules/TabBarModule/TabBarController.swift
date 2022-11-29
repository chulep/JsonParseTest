//
//  MyTabBarController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        let navController = ModuleBuilder.createSearchModule()
        navController.tabBarItem.title = "Search"
        navController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let favoriteViewController = ModuleBuilder.createFavoriteModule()
        favoriteViewController.tabBarItem.title = "Save"
        favoriteViewController.tabBarItem.image = UIImage(systemName: "heart")
        
        viewControllers = [navController, favoriteViewController]
    }

}
