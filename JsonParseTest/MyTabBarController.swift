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
        let navController = ModuleBuilder.createSearchModule()
        
        viewControllers = [navController]
    }

}
