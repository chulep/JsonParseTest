//
//  UIAlertController+Extension.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 06.12.2022.
//

import UIKit

extension UIAlertController {
    
    static func createErrorAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ок", style: .cancel)
        alertController.addAction(cancelButton)
        return alertController
    }
}
