//
//  SigninDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SigninAPIResponseDelegate: AnyObject {
    func loginSuccess(withData: LoginResponseModel)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class SigninDataManager: APIResponseHandler {
    
    var apiResponseDelegate: SigninAPIResponseDelegate?
    lazy var localDataManager = SigninLocalDataManager()
    lazy var apiDataManager = SigninAPIDataManager()
    
    // Data fetch service methods goes here
    func loginUserCall(phone: String,password: String){
        
        apiDataManager.loginUserCall(phone: phone,
                                     password: password) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                /*
                IEUserDefaults.shared.socialLogin = responseData?.social
                IEUserDefaults.shared.apiToken = responseData?.token
                IEUserDefaults.shared.userDetails = responseData?.customer_details
                IEUserDefaults.shared.totalCartCount = responseData?.cart_items?.items
                IEUserDefaults.shared.notificationCount = responseData?.notification_count
                IEUserDefaults.shared.cartID = responseData?.cart_items?.cartId
                */
                welf.apiResponseDelegate?.loginSuccess(withData: responseData!)
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
