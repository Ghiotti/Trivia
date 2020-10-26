//
//  RoundedButton.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import UIKit

class RoundedButton: UIButton {

    private let activityIndicatorView = UIActivityIndicatorView(style: .white)

    // MARK: View Lifecycle

    override func awakeFromNib() {
        setupUI()
    }

    // MARK: Private Methods

    private func setupUI() {
        layer.cornerRadius = bounds.height/2
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .disabled)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        backgroundColor = .colorSecondary
        activityIndicatorView.frame = bounds
    }

    // MARK: Public Methods

    func startLoading() {
        setTitleColor(backgroundColor, for: .normal)
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
    }

    func stopLoading() {
        setTitleColor(.white, for: .normal)
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
}
