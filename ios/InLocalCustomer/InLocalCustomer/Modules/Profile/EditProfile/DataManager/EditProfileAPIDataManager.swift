//
//  EditProfileAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias EditProfileCompletion = (_ successResponse: EditProfileResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class EditProfileAPIDataManager : APIDataManager{
    init() {
    }
    
    // Data fetch service methods goes here
    func editUserProfileCall(
        fullname: String,
        email: String,
        phone : String,
                    completion: @escaping EditProfileCompletion) {
        
           let params = [
            "fullname" : fullname,
            "email" : email,
               "phone": phone
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: AuthenticationEndpoints.updateProfile,
                       withParameters: params,
                       completion: completion)
       }
    
}
