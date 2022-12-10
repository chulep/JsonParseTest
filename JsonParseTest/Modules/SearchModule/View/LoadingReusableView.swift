//
//  LoadingReusableView.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.12.2022.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    
    static let identifire = "loadingView"
        
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(activityIndicator)
        activityIndicator.frame = bounds
    }
    
    func animating(_ bool: Bool?) {
        switch bool {
        case false:
            activityIndicator.stopAnimating()
        default:
            activityIndicator.startAnimating()
        }
    }
}
