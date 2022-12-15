//
//  MyTabBarController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 10.11.2022.
//

import UIKit

class TabBarController: UITabBarController, TabBarControllerType {
    
    required convenience init(viewControllers: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        tabBar.tintColor = ColorHelper.purple
    }
}
