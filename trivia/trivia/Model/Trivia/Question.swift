//
//  Question.swift
//  trivia
//
//  Created by Franco Ghiotti on 24/10/2020.
//

import Foundation
import ObjectMapper

class Question: Mappable {

    var category: String?
    var multiple: String?
    var difficulty: String?
    var question: String?
    var correctAnswer: String?
    var incorrectAnswers: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        category <- map["category"]
        multiple <- map["type"]
        difficulty <- map["difficulty"]
        question <- map["question"]
        correctAnswer <- map["correct_answer"]
        incorrectAnswers <- map["incorrect_answers"]
    }
}
