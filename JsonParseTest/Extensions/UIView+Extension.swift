//
//  UIView + Extension.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.12.2022.
//

import UIKit

extension UIView {
    
    func disappearAnimation(withDuration: Double, deadline: Double, toAlpha: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            UIView.animate(withDuration: withDuration) {
                self.alpha = toAlpha
            }
        }
    }
    
    func appearForAlpha(_ alpha: Double, withDuration: Double) {
        UIView.animate(withDuration: withDuration) {
            switch alpha {
            case 0:
                self.alpha = 1
            default:
                self.alpha = 0
            }
        }
    }
}
