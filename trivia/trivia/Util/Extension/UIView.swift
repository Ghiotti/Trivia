//
//  UIView.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import UIKit

var vSpinner : UIView?

extension UIView {

    func showSpinner() {
        let spinnerView = UIView.init(frame: self.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func hideSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
