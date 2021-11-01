//
//  SavedPostsAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias GetSavedPostCompletion = (_ successResponse: SavedPostResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class SavedPostsAPIDataManager : APIDataManager{
    init() {
    }
    // Data fetch service methods goes here
    func getSavedPostCall(skip: Int, limit: Int, loginUserType: String, completion: @escaping GetSavedPostCompletion) {
           let params = [
            "login_user_type" : "Customer",
            "post_user_type" : loginUserType,
            "limit" : limit,
            "skip" : skip
            ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getSavedPost,
                       withParameters: params,
                       completion: completion)
       }
}
