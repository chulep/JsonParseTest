//
//  LaunchViewController.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 12.12.2022.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    private let image = UIImage(named: "logo")
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }
    
    private func build() {
        imageView.image = image
        view.addSubview(imageView)
        let side = view.bounds.width / 1.5
        imageView.bounds.size = CGSize(width: side, height: side)
        imageView.center = view.center
    }
}
