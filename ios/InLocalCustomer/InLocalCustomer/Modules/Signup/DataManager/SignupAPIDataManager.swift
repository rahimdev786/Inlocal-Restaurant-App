//
//  SignupAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias SignupCompletion = (_ successResponse: SignupResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

typealias VerifyOTPCompletion = (_ successResponse: LoginResponseModel?, _ errorResponse: APIError?, _ error: Error?) -> Void

class SignupAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func signupUserCall(
                    fullname: String,
                    email: String,
                    phone:String,
                    countryCode:String,
                    password:String,
                    completion: @escaping SignupCompletion) {
           
        let params = [
                "fullname": fullname,
                "email": email,
                "phone": phone,
                "countryCode" : countryCode,
                "dail_code": "+91",
                "password" : password
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.register,
                       withParameters: params,
                       completion: completion)
       }
    
    
    func verifyOTPCall(
                    id: Int,
                    otp: String,
                    completion: @escaping VerifyOTPCompletion) {
           
        let params = [
                "id": id,
                "otp": otp
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.verifyRegistration,
                       withParameters: params,
                       completion: completion)
       }
}
