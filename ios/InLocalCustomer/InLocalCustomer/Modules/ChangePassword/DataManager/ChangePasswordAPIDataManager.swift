//
//  ChangePasswordAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias ChangePasswordCompletion = (_ successResponse: ChangePasswordResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class ChangePasswordAPIDataManager: APIDataManager{

    init() {
    }
    
    // Data fetch service methods goes here
    func changePasswordCall(
                            newPassword: String,
                            oldPassword: String,
                            completion: @escaping ChangePasswordCompletion) {
           let params = [
               "newPassword": newPassword,
               "oldPassword": oldPassword,
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.changePassword,
                       withParameters: params,
                       completion: completion)
       }
}
