//
//  BaseModel.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {

    var responseCode = ""

    required init?(map: Map) { }

    required init() { }

    func mapping(map: Map) {
        responseCode <- map["response_code"]
    }
}
