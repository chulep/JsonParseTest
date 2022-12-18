//
//  LaunchScreenProtocol.swift
//  PicSearch
//
//  Created by Pavel Schulepov on 18.12.2022.
//

import UIKit

protocol LaunchScreenPresenterType {
    func present(windowScene: UIWindowScene)
    func dismiss(completion: @escaping () -> Void)
}
