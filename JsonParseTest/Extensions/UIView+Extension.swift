//
//  UIView + Extension.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 08.12.2022.
//

import UIKit

extension UIView {
    func appearAnimation(withDuration: Double, deadline: Double?, toAlpha: Double) {
        let deadline = deadline ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            UIView.animate(withDuration: withDuration) {
                self.alpha = toAlpha
            }
        }
    }
    
    func appearAnimation(currentAlpha: Double, withDuration: Double) {
        UIView.animate(withDuration: withDuration) {
            switch currentAlpha {
            case 0:
                self.alpha = 1
            default:
                self.alpha = 0
            }
        }
    }
}
