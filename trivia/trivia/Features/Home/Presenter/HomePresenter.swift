//
//  HomePresenter.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import Foundation

protocol HomeDelegate {
    func willCallTriviaService()
    func onServiceResponseError(message: String)
    func onGetTrivia(trivia: Trivia, message: String)
    func triviaEnable()
    func triviaDisable()
}

class HomePresenter {

    private let view: HomeDelegate
    private let triviaService: TriviaServiceDelegate
    private var playerOneName = ""
    private var playerTwoName = ""

    init(view: HomeDelegate, triviaService: TriviaServiceDelegate) {
        self.view = view
        self.triviaService = triviaService
    }

    func onPressStartButton() {
        view.willCallTriviaService()

        triviaService.fetchTrivia() { [weak self] (trivia, error) in
            guard let weakSelf = self else {
                return
            }

            if let error = error {
                print(error)
                weakSelf.view.onServiceResponseError(message: error.localizedDescription)

                return
            }

            guard let trivia = trivia else {
                weakSelf.view.onServiceResponseError(message: "Ups, something was wrong, please try in other moment")

                return
            }

            trivia.participantOne = weakSelf.playerOneName
            trivia.participantTwo = weakSelf.playerTwoName
            weakSelf.processTrivia(trivia: trivia)
            weakSelf.view.onGetTrivia(trivia: trivia, message: "Start with:\n \(weakSelf.playerOneName)")
        }
    }

    func setPlayerOneName(name: String?) {
        playerOneName = name ?? ""
        validateStartTrivia()
    }

    func setPlayerTwoName(name: String?) {
        playerTwoName = name ?? ""
        validateStartTrivia()
    }

    private func processTrivia(trivia: Trivia) {
        for question in trivia.questions! {
            question.correctAnswer = String(htmlEncodedString: question.correctAnswer!)
            question.question = String(htmlEncodedString: question.question ?? "")
            for index in 0...(question.incorrectAnswers!.count - 1) {
                question.incorrectAnswers![index] = String(htmlEncodedString: question.incorrectAnswers![index])!
            }
        }
    }

    private func isValidName(name: String?) -> Bool {
        guard let name = name else {
            return false
        }

        if name.trimmingCharacters(in: CharacterSet(charactersIn: "")).isEmpty {
            return false
        }

        return true
    }

    private func validateStartTrivia() {
        if isValidName(name: playerOneName) && isValidName(name: playerTwoName) {
            view.triviaEnable()
        } else {
            view.triviaDisable()
        }
    }
}
