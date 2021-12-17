//
//  ProfileInfoAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias LogoutCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class ProfileInfoAPIDataManager : APIDataManager {
    init() {
    }
    // Data fetch service methods goes here
    func logoutUserCall(
                    completion: @escaping LogoutCompletion) {
           
          
           makeAPICall(to: AuthenticationEndpoints.logout,
                       withParameters: nil,
                       completion: completion)
       }
}
