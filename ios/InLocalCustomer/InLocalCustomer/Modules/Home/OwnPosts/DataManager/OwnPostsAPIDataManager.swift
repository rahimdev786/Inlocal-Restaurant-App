//
//  OwnPostsAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 05/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class OwnPostsAPIDataManager : APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func customerDetailsCall(customerId: Int,
                        completion: @escaping CustomerDetailCompletion) {
           let params = [
                "customer_id": customerId
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getCustomerDetails,
                       withParameters: params,
                       completion: completion)
    }
    
    func userPostListCall(userId: Int,
                                skip: Int,
                                limit: Int,
                        completion: @escaping UserPostListCompletion) {
           let params = [
                "skip": skip,
                "limit": limit,
                "customer_id": userId,
                "login_user_type": "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getCustomerPostList,
                       withParameters: params,
                       completion: completion)
    }
}
