//
//  ChangePasswordDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ChangePasswordAPIResponseDelegate : AnyObject {
    func changePasswordSuccess(withData: EmptyResponse?)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class ChangePasswordDataManager : APIResponseHandler{
    
    var apiResponseDelegate: ChangePasswordAPIResponseDelegate?
    lazy var localDataManager = ChangePasswordLocalDataManager()
    lazy var apiDataManager = ChangePasswordAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func changePasswordCall(userId: Int, newPassword: String, oldPassword: String){
        
        apiDataManager.changePasswordCall(userId: userId, newPassword: newPassword,
                                          oldPassword: oldPassword) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.changePasswordSuccess(withData: responseData)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    //welf.apiResponseDelegate?.showVerifyEmailScreen(responseError!)
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
