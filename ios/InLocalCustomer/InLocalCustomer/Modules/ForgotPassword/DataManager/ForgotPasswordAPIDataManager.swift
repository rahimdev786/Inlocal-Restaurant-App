//
//  ForgotPasswordAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias ForgotPasswordCompletion = (_ successResponse: ForgotPasswordResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

typealias ForgotPasswordVerifyOTPCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class ForgotPasswordAPIDataManager: APIDataManager{

    init() {
    }
    
    // Data fetch service methods goes here
    func forgotPasswordCall(
                    countryCode: String,
                    phone: String,
                    completion: @escaping ForgotPasswordCompletion) {
           let params = [
               "countryCode": countryCode,
               "phone": phone,
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.forgotPassword,
                       withParameters: params,
                       completion: completion)
       }
    
    func changePasswordVerifyOTPCall(id: Int, otp: String,
                    completion: @escaping ForgotPasswordVerifyOTPCompletion) {
           let params = [
               "id": id,
               "otp": otp,
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.verifyOTP,
                       withParameters: params,
                       completion: completion)
       }
}
