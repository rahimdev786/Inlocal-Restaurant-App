//
//  SetNewPasswordDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SetNewPasswordAPIResponseDelegate {
    func setNewPasswordSuccess(withData: SetNewPasswordResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class SetNewPasswordDataManager: APIResponseHandler {
    
    var apiResponseDelegate: SetNewPasswordAPIResponseDelegate?
    lazy var localDataManager = SetNewPasswordLocalDataManager()
    lazy var apiDataManager = SetNewPasswordAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func setNewPasswordCall(id: String,password: String){
        
        apiDataManager.setNewPasswordCall(id: id,
                                     password: password) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.setNewPasswordSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    //welf.apiResponseDelegate?.showVerifyEmailScreen(responseError!)
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
