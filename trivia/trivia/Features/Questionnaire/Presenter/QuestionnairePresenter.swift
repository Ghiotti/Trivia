//
//  QuestionnairePresenter.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import Foundation

protocol QuestionnaireDelegate {
    func onSelectCorrectOption(index: Int)
    func onSelectWrongOption(correctOption: Int, incorrectOption: Int)
    func onLastQuestion()
    func onFinishParticipantTurn(trivia: Trivia, message: String)
    func onFinishTrivia(trivia: Trivia, message: String)
    func nextQuestion(trivia: Trivia)
}

class QuestionnairePresenter {

    private let view: QuestionnaireDelegate
    private let trivia: Trivia
    private var answers: [String] = []
    private let questionNumberToShow: Int
    private var numberOfQuestion: Int {
        set {
        }
        get {
            if !trivia.participantOneFinis {
                return questionNumberToShow
            }

            return questionNumberToShow + 10
        }
    }

    init(view: QuestionnaireDelegate, trivia: Trivia, numberOfQuestion: Int) {
        self.view = view
        self.trivia = trivia
        self.questionNumberToShow = numberOfQuestion
        self.numberOfQuestion = numberOfQuestion
        self.setUpTrivia()
    }

    func getQuestionTitle() -> String {
        let questionTitle = trivia.questions?[numberOfQuestion].question ?? ""

        return "Question \(questionNumberToShow + 1)/10: \n\(questionTitle)"
    }

    func numberOfQuestions() -> Int {
        return answers.count
    }

    func getOptions(index: Int) -> String {
        return answers[index]
    }

    func onSelectOption(index: Int) {
        guard let correctOption = trivia.questions?[numberOfQuestion].correctAnswer else {
            return
        }

        if correctOption == answers[index] {
            trivia.questions?[numberOfQuestion].result = true
            view.onSelectCorrectOption(index: index)

            return
        }

        let correctIndex = answers.firstIndex { (option) -> Bool in
            return correctOption == option
        }

        if correctIndex != nil {
            trivia.questions?[numberOfQuestion].result = false
            view.onSelectWrongOption(correctOption: correctIndex!, incorrectOption: index)
        }
    }

    func onSelectNextQuestion() {
        guard let numberOfQuestions = trivia.questions?.count else {
            return
        }

        if questionNumberToShow + 1 == numberOfQuestions/2 {
            if trivia.participantOneFinis  {
                view.onFinishTrivia(trivia: trivia, message: calculateWinner())

                return
            }

            trivia.participantOneFinis = true
            view.onFinishParticipantTurn(trivia: trivia, message: "Now is \(trivia.participantTwo) turn, good luck!")

            return
        }

        view.nextQuestion(trivia: trivia)
    }

    private func calculateWinner() -> String {
        let firstPlayerQuestions = trivia.questions?[0...9]
        let secondPlayerQuestions = trivia.questions?[10...19]

        let firstPlayerCorrectAnswersCount = firstPlayerQuestions?.filter({ (question) -> Bool in
            return question.result == true
        }).count

        let secondPlayerCorrectAnswersCount = secondPlayerQuestions?.filter({ (question) -> Bool in
            return question.result == true
        }).count

        guard let firstPlayerCorrectAnswers = firstPlayerCorrectAnswersCount,
              let secondPlayerCorrectAnswers = secondPlayerCorrectAnswersCount else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: Date())

        if firstPlayerCorrectAnswers == secondPlayerCorrectAnswers {
            saveResults(result: "\(trivia.participantOne) \(firstPlayerCorrectAnswers)  \(secondPlayerCorrectAnswers) \(trivia.participantTwo)     \(currentDate)")
            return "Both players have obtained \(firstPlayerCorrectAnswers) points. It was a draw"
        }

        if firstPlayerCorrectAnswers > secondPlayerCorrectAnswers {
            saveResults(result: "\(trivia.participantOne) \(firstPlayerCorrectAnswers)  \(secondPlayerCorrectAnswers) \(trivia.participantTwo)     \(currentDate)")
            return "The winner is \(trivia.participantOne) with \(firstPlayerCorrectAnswers) corrects answers, while \(trivia.participantTwo) got \(secondPlayerCorrectAnswers) correct answers"
        } else {
            saveResults(result: "\(trivia.participantOne) \(firstPlayerCorrectAnswers)  \(secondPlayerCorrectAnswers) \(trivia.participantTwo)     \(currentDate)")
            return "The winner is \(trivia.participantTwo) with \(secondPlayerCorrectAnswers) corrects answers, while \(trivia.participantOne) got \(firstPlayerCorrectAnswers) correct answers"
        }
    }

    private func saveResults(result: String) {
        CoreDataMannager().addResult(resultToSave: result)
    }

    private func setUpTrivia() {
        guard let triviaIncorrectAnswers = trivia.questions?[numberOfQuestion].incorrectAnswers else {
            return
        }

        guard let correctAnswer = trivia.questions?[numberOfQuestion].correctAnswer else {
            return
        }

        answers = triviaIncorrectAnswers
        answers.append(correctAnswer)
        answers.shuffle()
    }
}
