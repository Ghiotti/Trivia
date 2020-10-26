//
//  UIViewController.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import UIKit

extension UIViewController {

    func presentAlertView(title: String, text: String, buttonText: String, cancelButton: Bool = false) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default, handler: nil))
        if cancelButton {
            alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        }

        self.present(alert, animated: true, completion: nil)
    }

    func presentAlertViewWith(title: String, text: String, buttonText: String, cancelButton: Bool = false, action: @escaping(() -> Void)) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { (alert) in
            action()
        }))
        if cancelButton {
            alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
