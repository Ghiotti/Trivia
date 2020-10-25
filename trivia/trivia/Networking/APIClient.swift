//
//  APIClient.swift
//  trivia
//
//  Created by Franco Ghiotti on 24/10/2020.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class APIClient {

    func getEntity<T: BaseModel>(endpoint: String, parameters: [String: Any]? = nil, completion:@escaping (_ entity: T?, _ error: Error?) -> Void) -> DataRequest {
        let request = createRequest(endpoint: endpoint, method: .get, parameters: parameters)
            .responseObject { response -> Void in
                APIErrorHandler().validateObject(response) { (entity, error) in
                    completion(entity, error)
                }
        }

        return request
    }

    private func createRequest(endpoint: String, method: Alamofire.HTTPMethod, parameters: [String: Any]?) -> DataRequest {
        let urlString = Constants.Endpoints.baseUrl
        let params = parameters ?? [:]

        let request = Alamofire.request(urlString, method: method, parameters: params)
            .responseString { response in
                debugPrint("Response: \(response)")
        }

        debugPrint(request)

        return request
    }
}
