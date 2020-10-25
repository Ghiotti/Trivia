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
    func onGetTrivia(trivia: Trivia)
}

class HomePresenter {

    private let view: HomeDelegate
    private let triviaService: TriviaServiceDelegate
    private let playerOneName = ""
    private let playerTwoName = ""

    init(view: HomeDelegate, triviaService: TriviaServiceDelegate) {
        self.view = view
        self.triviaService = triviaService
    }

    func onPressStartButton() {
        view.willCallTriviaService()

        triviaService.fetchTrivia(category: 1) { [weak self] (trivia, error) in
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

            weakSelf.view.onGetTrivia(trivia: trivia)
        }
    }

    
}
