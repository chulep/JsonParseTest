//
//  UIImage+Extension.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.12.2022.
//

import UIKit

extension UIImage {
    
    convenience init(isFavorite: Bool?) {
        switch isFavorite {
        case true:
            self.init(systemName: "heart.fill")!
        default:
            self.init(systemName: "heart")!
        }
    }
}
