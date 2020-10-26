//
//  QuestionnaireViewController.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    @IBOutlet weak var questionnaireTableView: UITableView!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var questionTitle: UILabel!

    private var presenter: QuestionnairePresenter!
    private let cellIdentifier = "questionnaireCellIdentifier"

    var trivia: Trivia!
    var questionNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = QuestionnairePresenter(view: self, trivia: trivia, numberOfQuestion: questionNumber)
        self.questionnaireTableView.delegate = self
        self.questionnaireTableView.dataSource = self
        self.setUpUI()
    }

    private func setUpUI() {
        questionTitle.text = presenter.getQuestionTitle()
        navigationItem.setHidesBackButton(true, animated: false)
        nextQuestionButton.isHidden = true
    }

    @IBAction func onPressNextQuestion(_ sender: Any) {
        presenter.onSelectNextQuestion()
    }
}

extension QuestionnaireViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onSelectOption(index: indexPath.row)
    }
}

extension QuestionnaireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfQuestions()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? QuestionnaireCell else {
            return UITableViewCell()
        }

        cell.setUpCell(answerString: presenter.getOptions(index: indexPath.row))

        return cell
    }
}

extension QuestionnaireViewController: QuestionnaireDelegate {

    func onSelectCorrectOption(index: Int) {
        questionnaireTableView.isUserInteractionEnabled = false
        nextQuestionButton.isHidden = false
        
        guard let cell = questionnaireTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? QuestionnaireCell else {
            return
        }

        cell.setCorrectAnswer()
    }

    func onSelectWrongOption(correctOption: Int, incorrectOption: Int) {
        nextQuestionButton.isHidden = false
        questionnaireTableView.isUserInteractionEnabled = false

        guard let correctCell = questionnaireTableView.cellForRow(at: IndexPath(row: correctOption, section: 0)) as? QuestionnaireCell else {
            return
        }

        guard let wrongCell = questionnaireTableView.cellForRow(at: IndexPath(row: incorrectOption, section: 0)) as? QuestionnaireCell else {
            return
        }

        correctCell.setCorrectAnswer()
        wrongCell.setWrongAnswer()
    }

    func onLastQuestion() {
        nextQuestionButton.setTitle("Finish", for: .normal)
    }

    func onFinishTrivia(trivia: Trivia, message: String) {
        presentAlertViewWith(title: "", text: message, buttonText: "Accept") {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    func nextQuestion(trivia: Trivia) {
        let questionnaireStoryBoard = UIStoryboard.init(name: "Questionnaire" , bundle: nil)
        let navController = questionnaireStoryBoard.instantiateInitialViewController() as? UINavigationController
        let questionnaireViewController = navController?.viewControllers.first as? QuestionnaireViewController
        questionnaireViewController?.questionNumber = questionNumber + 1
        questionnaireViewController?.trivia = trivia

        navigationController?.pushViewController(questionnaireViewController!, animated: true)
    }

    func onFinishParticipantTurn(trivia: Trivia, message: String) {
        presentAlertViewWith(title: "", text: message, buttonText: "Accept") {
            let questionnaireStoryBoard = UIStoryboard.init(name: "Questionnaire" , bundle: nil)
            let navController = questionnaireStoryBoard.instantiateInitialViewController() as? UINavigationController
            let questionnaireViewController = navController?.viewControllers.first as? QuestionnaireViewController
            questionnaireViewController?.questionNumber = 0
            questionnaireViewController?.trivia = trivia

            self.navigationController?.pushViewController(questionnaireViewController!, animated: true)
        }
    }
}
