//
//  TagedPhotosAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias CustomerPostListCompletion = (_ successResponse: CustomerPostListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class TagedPhotosAPIDataManager : APIDataManager{

    init() {
    }
    
    // Data fetch service methods goes here
    func customerPostListCall(
                        skip: Int,
                        limit: Int,
                        customerId: Int,
                        completion: @escaping CustomerPostListCompletion) {
           let params = [
                "skip": skip,
                "limit": limit,
                "customer_id" : customerId,
                "login_user_type" : "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getCustomerPostList,
                       withParameters: params,
                       completion: completion)
    }
}
