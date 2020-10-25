//
//  QuestionnairePresenter.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import Foundation

protocol QuestionnaireDelegate {
    func onSelectCorrectOption(index: Int)
    func onSelectWrongOption(index: Int)
}

class QuestionnairePresenter {

    private let view: QuestionnaireDelegate
    private let trivia: Trivia
    private let numberOfQuestion: Int
    private var answers: [String] = []

    init(view: QuestionnaireDelegate, trivia: Trivia, numberOfQuestion: Int) {
        self.view = view
        self.trivia = trivia
        self.numberOfQuestion = numberOfQuestion
        self.setUpTrivia()
    }

    func numberOfQuestions() -> Int {
        return trivia.questions?.count ?? 0
    }

    func getOptions(index: Int) -> String {
        return answers[index]
    }

    func onSelectOption(index: Int) {
        guard let correctOption = trivia.questions?[numberOfQuestion].correctAnswer else {
            return
        }

        if correctOption == answers[index] {
            view.onSelectCorrectOption(index: index)

            return
        }

        view.onSelectWrongOption(index: index)
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
