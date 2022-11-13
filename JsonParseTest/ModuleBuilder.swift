//
//  ModuleBuilder.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 13.11.2022.
//

import UIKit

final class ModuleBuilder {
    static func createNavigationBarApperance(backgroundColor: UIColor, textColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : textColor]
    }
}
