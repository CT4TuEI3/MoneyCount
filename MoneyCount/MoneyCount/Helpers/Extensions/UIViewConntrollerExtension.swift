//
//  UIViewConntrollerExtension.swift
//  MoneyCount
//
//  Created by Алексей on 22.02.2023.
//

import UIKit

extension UIViewController {
    /// Show error alert
    /// - Parameters:
    ///   - title: Title alert
    ///   - error: Error text
    func showErrorAlert(title: String? = "Error", error: Error?) {
        let errorAlert = UIAlertController(title: title,
                                           message: error?.localizedDescription,
                                           preferredStyle: .alert )
        errorAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(errorAlert, animated: true)
    }
}
