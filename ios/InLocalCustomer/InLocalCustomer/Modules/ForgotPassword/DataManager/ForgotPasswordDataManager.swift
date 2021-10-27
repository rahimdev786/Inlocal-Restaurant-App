//
//  ForgotPasswordDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ForgotPasswordAPIResponseDelegate {
    func forgotPasswordSuccess(withData: ForgotPasswordResponse)
    func forgotPasswordVerifyOTPSuccess(withData: EmptyResponse?)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class ForgotPasswordDataManager: APIResponseHandler {
    
    var apiResponseDelegate: ForgotPasswordAPIResponseDelegate?
    lazy var localDataManager = ForgotPasswordLocalDataManager()
    lazy var apiDataManager = ForgotPasswordAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func forgotPasswordCall(countryCode: String, phone: String){
        
        apiDataManager.forgotPasswordCall(countryCode: countryCode,
                                       phone: phone) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                
                welf.apiResponseDelegate?.forgotPasswordSuccess(withData: responseData!)
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
    
    func changePasswordVerifyOTPCall(id: Int, otp: String){
        
        apiDataManager.changePasswordVerifyOTPCall(id: id,
                                          otp: otp) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                
                welf.apiResponseDelegate?.forgotPasswordVerifyOTPSuccess(withData: responseData)
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
