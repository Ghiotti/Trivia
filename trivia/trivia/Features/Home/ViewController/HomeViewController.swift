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
    @IBOutlet weak var startButton: RoundedButton!

    private let categoryPicker = UIPickerView()
    private var presenter: HomePresenter!

    // MARK: View Controller Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()

        playerOneTextField.addTarget(self, action: #selector(onEditPlayerOne(_:)), for: .editingChanged)
        playerTwoTextField.addTarget(self, action: #selector(onEditPlayerTwo(_:)), for: .editingChanged)
        presenter = HomePresenter(view: self, triviaService: NetworkManager())
        setUpUI()
    }

    // MARK: Private Methods

    private func setUpUI() {
        triviaDisable()
    }

    private func presentTrivia(trivia: Trivia) {
        let questionnaireStoryBoard = UIStoryboard.init(name: "Questionnaire" , bundle: nil)
        let questionnaireViewController = questionnaireStoryBoard.instantiateInitialViewController() as? UINavigationController
        (questionnaireViewController?.viewControllers.first as? QuestionnaireViewController)?.questionNumber = 0
        (questionnaireViewController?.viewControllers.first as? QuestionnaireViewController)?.trivia = trivia
        present(questionnaireViewController!, animated: true, completion: nil)
    }

    @objc private func onEditPlayerOne(_ textField: UITextField) {
        presenter.setPlayerOneName(name: textField.text)
    }

    @objc private func onEditPlayerTwo(_ textField: UITextField) {
        presenter.setPlayerTwoName(name: textField.text)
    }

    // MARK: IBAction

    @IBAction func onPressStartButton(_ sender: Any) {
        presenter.onPressStartButton()
    }

    @IBAction func onSelectMatchHistory(_ sender: Any) {
        let matchHystoryViewController = MatchsHistoryTableViewController()
        self.present(matchHystoryViewController, animated: true, completion: nil)
    }
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

// MARK: HomeDelegate

extension HomeViewController: HomeDelegate {

    func willCallTriviaService() {
        startButton.isEnabled = false
        startButton.showSpinner()
    }

    func onServiceResponseError(message: String) {
        startButton.isEnabled = true
        startButton.hideSpinner()
        presentAlertView(title: "Error", text: message, buttonText: "Accept")
    }

    func onGetTrivia(trivia: Trivia, message: String) {
        startButton.isEnabled = true
        startButton.hideSpinner()
        presentAlertViewWith(title: "", text: message, buttonText: "Accept") {
            self.presentTrivia(trivia: trivia)
        }
    }

    func triviaEnable() {
        startButton.isEnabled = true
        startButton.backgroundColor = .colorPrimary
    }

    func triviaDisable() {
        startButton.isEnabled = false
        startButton.backgroundColor = .lightGray
    }
}
