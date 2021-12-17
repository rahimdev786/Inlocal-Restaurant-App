//
//  ProfileInfoDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ProfileInfoAPIResponseDelegate: class {
    func logoutSuccess(withData: EmptyResponse?)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class ProfileInfoDataManager : APIResponseHandler {
    weak var apiResponseDelegate: ProfileInfoAPIResponseDelegate?
    lazy var localDataManager = ProfileInfoLocalDataManager()
    lazy var apiDataManager = ProfileInfoAPIDataManager()
    init() {
    }
    
    // Data fetch service methods goes here
    // Data fetch service methods goes here
    func logoutUserCall(){
        
        apiDataManager.logoutUserCall() {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                IEUserDefaults.shared.isUserLoggedIn = false
                welf.apiResponseDelegate?.logoutSuccess(withData: responseData)
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
