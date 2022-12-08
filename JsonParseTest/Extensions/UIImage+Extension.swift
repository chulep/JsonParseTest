//
//  UIImage+Extension.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.12.2022.
//

import UIKit

extension UIImage {
    
    func createFavoriteImage(_ isFavorite: Bool?) -> UIImage {
        switch isFavorite {
        case true:
            return UIImage(systemName: "heart.fill")!
        default:
            return UIImage(systemName: "heart")!
        }
    }
}
