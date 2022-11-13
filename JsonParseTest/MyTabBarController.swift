//
//  MyTabBarController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        let viewController = SearchViewController(collectionViewLayout: createFlowLayout())
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = "Search"
        navController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let favoriteViewController = FavoriteViewController()
        let navController2 = UINavigationController(rootViewController: favoriteViewController)
        navController2.tabBarItem.title = "Save"
        navController2.tabBarItem.image = UIImage(systemName: "heart")
        viewControllers = [navController, navController2]
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width / 2 - 15, height: view.bounds.width / 2 - 15)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }

}
