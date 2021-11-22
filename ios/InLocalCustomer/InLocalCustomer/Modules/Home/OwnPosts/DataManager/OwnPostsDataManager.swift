//
//  OwnPostsDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 05/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol OwnPostsAPIResponseDelegate {
    func customerDetailSuccess(withData: CustomerDetailResponse)
    func userPostListSuccess(withData: UserPostListResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class OwnPostsDataManager: APIResponseHandler {
    
    var apiResponseDelegate: OwnPostsAPIResponseDelegate?
    lazy var localDataManager = OwnPostsLocalDataManager()
    lazy var apiDataManager = OwnPostsAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func customerDetailsCall(customerId: Int){
        
        apiDataManager.customerDetailsCall(customerId: customerId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.customerDetailSuccess(withData: responseData!)
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
    
    func userPostListCall(userId: Int, skip: Int, limit: Int){
        
        apiDataManager.userPostListCall(userId: userId, skip: skip, limit: limit) {[weak self] (responseData, responseError, error) in
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.userPostListSuccess(withData: responseData!)
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
