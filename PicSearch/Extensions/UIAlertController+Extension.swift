//
//  UIAlertController+Extension.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 06.12.2022.
//

import UIKit

extension UIAlertController {
    
    convenience init(errorMessage: String?) {
        self.init(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ок", style: .cancel)
        addAction(cancelButton)
    }
}
