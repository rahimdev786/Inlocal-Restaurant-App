//
//  SigninAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias LoginCompletion = (_ successResponse: LoginResponseModel?, _ errorResponse: APIError?, _ error: Error?) -> Void

class SigninAPIDataManager: APIDataManager{

    init() {
    }
    
    // Data fetch service methods goes here
    func loginUserCall(
                    phone: String,
                    password: String,
                    completion: @escaping LoginCompletion) {
           let params = [
               "phone": phone,
               "password": password,
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.login,
                       withParameters: params,
                       completion: completion)
       }
}
