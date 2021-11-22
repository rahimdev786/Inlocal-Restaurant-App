//
//  FollowerAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias FollowerListCompletion = (_ successResponse: FollowersListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class FollowerAPIDataManager : APIDataManager {
    
    init() {
    }
    
    // Data fetch service methods goes here
    func followerListCall(skip: Int,
                          limit: Int,
                        completion: @escaping FollowerListCompletion) {
           let params = [
            "login_user_type" : "Customer",
            "limit" : limit,
            "skip" : skip
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getFollowerList,
                       withParameters: params,
                       completion: completion)
    }
}
