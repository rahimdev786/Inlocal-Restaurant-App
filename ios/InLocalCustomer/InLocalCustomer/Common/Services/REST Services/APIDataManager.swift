//
//  APIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import Foundation
import Alamofire
import ObjectMapper

struct AppServerResponse<T: BaseMappable>: Mappable {
    
    var success: Bool!
    var apiError: APIError?
    var message : String?
    var data: T?

    
    init?(map: Map) {
        guard let _ = map.JSON["success"] else {
            //Log.e("Success is not present.")
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        apiError <- (map["code"], CustomTransformations.apiErrorCodeTransformation)
        data <- map["data"]
        message <- map["message"]

    }
}

struct AppServerListResponse<T: BaseMappable>: Mappable {
    
    var success: Bool!
    var apiError: APIError?
    var data: [T]?
    
    init?(map: Map) {
        guard let _ = map.JSON["success"] else {
            //Log.e("Success is not present.")
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        apiError <- (map["errorCode"], CustomTransformations.apiErrorCodeTransformation)
        data <- map["data"]
    }
}


typealias GenericCompletion<T: BaseMappable> = (
    _ successResponse: T?,
    _ errorResponse: APIError?,
    _ error: Error?) -> Void

typealias GenericArrayCompletion<T: BaseMappable> = (
    _ successResponse: [T]?,
    _ errorResponse: APIError?,
    _ error: Error?) -> Void


enum ParameterType {
    
    case httpBody
    case queryString
}

protocol APIDataManager: class {
    
}

extension APIDataManager {
    
    // API Call For Immutable Responses
    
    
    /// Method to make HTTP API call where the response is parsed as BaseMappable
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint  - describes URL and HTTP method
    ///   - parameters: key-value coded payload
    ///   - parameterType: payload encoding
    ///   - completion: block to be exceuted when the response is received
    
    @discardableResult
    func makeAPICall<T: BaseMappable>(to endpoint: APIEndpoint,
                                      withParameters parameters: Parameters? = nil,
                                      ofType parameterType: ParameterType = .httpBody,
                                      completion: @escaping GenericCompletion<T>) -> DataRequest {
        
        //Log.i("Headers: \(APIHeader.shared.headers)")
        //Log.i("Parameters: \(String(describing: parameters))")
        
        
        
        let dataRequest = AF.request(endpoint.urlPath,
                                     method: endpoint.method,
                                     parameters: parameters,
                                     encoding: parameterType == .queryString ? URLEncoding.queryString : JSONEncoding.default,
                                     headers: HTTPHeaders.init(APIHeader.shared.headers))
            .validate()
            .responseString { (response) in
                
                //Log.i("Request URL: \(response.request?.url?.absoluteString ?? "")")
                //  Log.i("Response Data: \(response.result.value ?? "")")
                // check for http response code 200 or network timeout
                
                switch (response.result){
                case .success(let responseString):
                    print(responseString)
                    guard let parsedData = AppServerResponse<T>(JSONString: responseString) else {
                        // No Response for 200
                        if let _ = IEUserDefaults.shared.apiToken {
                            completion(nil,nil,JsonResponseError.sessionOut)
                        } else {
                            completion(nil,nil,APIError.UNKNOWN_ERROR)
                        }
                        return
                    }
                    
                    if parsedData.success {
                        // DATA
                        guard let data = parsedData.data else {
                            // no data on succes true
                            completion(nil,nil,nil)
                            return
                        }
                        completion(data,nil,nil)
                    } else {
                        // error
                        guard let apiError = parsedData.apiError else {
                            // no error code on false success
                            completion(nil,nil,APIError.UNKNOWN_ERROR)
                            return
                        }
                        if apiError == APIError.code405 {
                            //Specialcase for deliverytype api . Data present when success is false
                            if let data = parsedData.data {
                                completion(data,apiError,nil)
                            } else {
                                completion(nil,apiError,nil)
                            }
                        } else {
                            completion(nil,apiError,nil)
                        }
                        
                    }
                    
                case .failure(let error):
                    //Log.e("Failed Request: \(error.localizedDescription)")
                    print(error.localizedDescription)
                    completion(nil, nil, error)
                }
            }
        dataRequest.resume()
        return dataRequest
    }
}
