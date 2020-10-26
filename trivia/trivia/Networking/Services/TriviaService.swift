//
//  TriviaService.swift
//  trivia
//
//  Created by Franco Ghiotti on 24/10/2020.
//

import Foundation

protocol TriviaServiceDelegate {

    func fetchTrivia(onComplete: @escaping (Trivia?, Error?) -> Void)
}

extension NetworkManager: TriviaServiceDelegate {

    func fetchTrivia(onComplete: @escaping (Trivia?, Error?) -> Void) {
        let parameters: [String: Any] = ["amount": Constants.Trivia.numberOfQuestions,
                                         "type": Constants.Trivia.typeOfQuestion]

        _ = APIClient().getEntity(endpoint: Constants.Endpoints.baseUrl, parameters: parameters, completion: { (questions, error) in
            onComplete(questions, error)
        })
    }
}
