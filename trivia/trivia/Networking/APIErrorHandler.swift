//
//  APIErrorHandler.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import Foundation
import Alamofire
import ObjectMapper

class APIErrorHandler {
    func validateObject<T: BaseModel>(_ response: DataResponse<T>, completion:(_ entity: T?, _ error: Error?) -> Void) {
        if let error = response.result.error {
            completion(nil, error)
            return
        }

        let object = response.result.value
        completion(object, nil)
    }
}
