//
//  SignupDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SignupAPIResponseDelegate {
    func signupSuccess(withData: SignupResponse)
    func verifyOTPSuccess(withData: LoginResponseModel)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class SignupDataManager : APIResponseHandler {
    
    var apiResponseDelegate: SignupAPIResponseDelegate?
    lazy var localDataManager = SignupLocalDataManager()
    lazy var apiDataManager = SignupAPIDataManager()
    
    init() {
        
    }
    
    // Data fetch service methods goes here
    func signupUserCall(fullname: String, email: String, phone: String, countryCode: String, password: String){
        
        apiDataManager.signupUserCall(fullname: fullname, email: email,
                                     phone: phone, countryCode: countryCode, password: password) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.signupSuccess(withData: responseData!)
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
    
    func verifyOTP(id: String, otp: String){
        
        apiDataManager.verifyOTPCall(id: id, otp: otp) {[weak self] (responseData, responseError, error) in
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.verifyOTPSuccess(withData: responseData!)
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
