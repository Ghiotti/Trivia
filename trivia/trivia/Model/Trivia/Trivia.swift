//
//  Trivia.swift
//  trivia
//
//  Created by Franco Ghiotti on 24/10/2020.
//

import Foundation
import ObjectMapper

class Trivia: BaseModel {

    var questions: [Question]?
    var participantOne = ""
    var participantTwo = ""
    var participantOneFinis = false

    required convenience init?(map: Map) {
        self.init()
    }

    override func mapping(map: Map) {
        super.mapping(map: map)

        questions <- map["results"]
    }
}
