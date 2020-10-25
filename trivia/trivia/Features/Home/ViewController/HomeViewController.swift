//
//  HomeViewController.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var selectCategoryTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!

    private let categoryPicker = UIPickerView()

    // MARK: View Controller Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Private Methods

    private func setUpUI() {
        categoryPicker.delegate = self
        selectCategoryTextField.inputView = categoryPicker
    }

    // MARK: IBAction

    @IBAction func onPressStartButton(_ sender: Any) {

    }
}

// MARK: UIPickerViewDelegate

extension HomeViewController: UIPickerViewDelegate {

}

// MARK: UIPickerViewDataSource

extension HomeViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
