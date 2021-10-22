//
//  UploadStoryDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 12/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol UploadStoryAPIResponseDelegate: class {
    func createStroySuccess(withData: EmptyResponse?)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class UploadStoryDataManager : APIResponseHandler {
    
    weak var apiResponseDelegate: UploadStoryAPIResponseDelegate?
    lazy var localDataManager = UploadStoryLocalDataManager()
    lazy var apiDataManager = UploadStoryAPIDataManager()
    
    // Data fetch service methods goes here
    func createStoryCall(image: UIImage){
     
        apiDataManager.createStoryCall(image: image) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.createStroySuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }else{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }
            } else if result.error {
                welf.apiResponseDelegate?.networkError(error!)
            } else {
                welf.apiResponseDelegate?.networkError(error!)
            }
        }
    }
}
