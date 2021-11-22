//
//  TagedPhotosDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol TagedPhotosAPIResponseDelegate {
    func customerPostListSuccess(withData: CustomerPostListResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class TagedPhotosDataManager : APIResponseHandler{
    
    var apiResponseDelegate: TagedPhotosAPIResponseDelegate?
    lazy var localDataManager = TagedPhotosLocalDataManager()
    lazy var apiDataManager = TagedPhotosAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    // Data fetch service methods goes here
    func customerPostListCall(skip: Int, limit: Int, customerId: Int){
        
        apiDataManager.customerPostListCall(skip: skip,
                                        limit: limit,
                                        customerId: customerId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.customerPostListSuccess(withData: responseData!)
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
