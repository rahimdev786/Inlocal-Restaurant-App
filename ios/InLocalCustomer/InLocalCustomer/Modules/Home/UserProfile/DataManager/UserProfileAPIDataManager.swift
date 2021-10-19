//
//  UserProfileAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias CustomerDetailCompletion = (_ successResponse: CustomerDetailResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

typealias UserPostListCompletion = (_ successResponse: UserPostListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class UserProfileAPIDataManager: APIDataManager {

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
