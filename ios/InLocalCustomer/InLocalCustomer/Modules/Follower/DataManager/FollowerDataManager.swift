//
//  FollowerDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol FollowerAPIResponseDelegate: class {
    func followersListSuccess(withData: FollowersListResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class FollowerDataManager : APIResponseHandler {
    weak var apiResponseDelegate: FollowerAPIResponseDelegate?
    lazy var localDataManager = FollowerLocalDataManager()
    lazy var apiDataManager = FollowerAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
    func followerListCall(skip: Int, limit: Int){
        
        apiDataManager.followerListCall(skip: skip, limit: limit) {[weak self] (responseData, responseError, error) in
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.followersListSuccess(withData: responseData!)
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
