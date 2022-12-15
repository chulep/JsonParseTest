//
//  LaunchScreenPresent.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 12.12.2022.
//

import UIKit

final class LaunchScreenPresenter {
    
    private let window = UIWindow()
    private let launchScreen = LaunchViewController()
    
    func present(windowScene: UIWindowScene) {
        window.windowScene = windowScene
        window.windowLevel = .normal + 1
        window.rootViewController = launchScreen
        window.backgroundColor = ColorHelper.white
        window.isHidden = false
    }
    
    func dismiss(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1) {
            self.window.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
}
