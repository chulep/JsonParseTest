//
//  ModuleBuilderProtocols.swift
//  PicSearch
//
//  Created by Pavel Schulepov on 18.12.2022.
//

import UIKit

protocol ModuleBuilderType {
    static func createStartTabBarModule() -> UITabBarController
    static func createSearchModule() -> UIViewController
    static func createFavoriteModule() -> UIViewController
    static func createDetailModule(viewModel: DetailViewModelType?) -> UINavigationController
}
