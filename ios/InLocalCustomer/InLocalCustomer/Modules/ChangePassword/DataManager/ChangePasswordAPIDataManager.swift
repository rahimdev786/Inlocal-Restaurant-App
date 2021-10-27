//
//  ChangePasswordAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias ChangePasswordCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class ChangePasswordAPIDataManager: APIDataManager{

    init() {
    }
    
    // Data fetch service methods goes here
    func changePasswordCall( userId: Int,
                            newPassword: String,
                            oldPassword: String,
                            completion: @escaping ChangePasswordCompletion) {
           let params = [
                "id": userId,
                "newPassword": newPassword,
                "oldPassword": oldPassword,
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.changePassword,
                       withParameters: params,
                       completion: completion)
       }
}
