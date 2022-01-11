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
        
        let dataRequest = AF.request(endpoint.urlPath,
                                     method: endpoint.method,
                                     parameters: parameters,
                                     encoding: parameterType == .queryString ? URLEncoding.queryString : JSONEncoding.default,
                                     headers: HTTPHeaders.init(APIHeader.shared.headers))
            .validate()
            .responseString { (response) in
                
                print("Request URL: \(response.request?.url?.absoluteString ?? "")")
                print("Headers: \(APIHeader.shared.headers)")
                print("Parameters: \(String(describing: parameters))")
                
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


extension APIDataManager{
    @discardableResult
    func createStoryCall<T: BaseMappable>(to endpoint: APIEndpoint,
                                      withImage image: UIImage,
                                      withParameters parameters: Parameters? = nil,
                                      ofType parameterType: ParameterType = .httpBody,
                                      completion: @escaping GenericCompletion<T>) -> DataRequest {
        
        let userData = ["story_user_type" : "Customer"]
        
        let imageData = image.jpegData(compressionQuality: 1.0)
        
        let dataRequest = AF.upload(multipartFormData: { (MultipartFormData) in
            
            for (key, value) in userData {
                MultipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }

            MultipartFormData.append(imageData!, withName: "profileImage", fileName: "picture.jpeg", mimeType: "image/jpeg")
            
            
        },to: endpoint.urlPath, usingThreshold: UInt64.init(),
          method: endpoint.method,
          headers: HTTPHeaders.init(APIHeader.shared.headers))
        .validate()
        .responseString{ response in
        
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
