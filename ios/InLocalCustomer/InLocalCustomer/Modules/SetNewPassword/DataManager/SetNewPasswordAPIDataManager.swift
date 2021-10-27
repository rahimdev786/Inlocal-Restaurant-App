//
//  SetNewPasswordAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias SetNewPasswordCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class SetNewPasswordAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func setNewPasswordCall(
                    id: Int,
                    password: String,
                    completion: @escaping SetNewPasswordCompletion) {
           let params = [
               "id": id,
               "password": password,
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.setNewPassword,
                       withParameters: params,
                       completion: completion)
       }
}
