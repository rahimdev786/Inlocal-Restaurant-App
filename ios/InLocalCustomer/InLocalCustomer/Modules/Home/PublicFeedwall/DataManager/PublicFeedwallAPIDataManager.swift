//
//  PublicFeedwallAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias FeedListCompletion = (_ successResponse: FeedWallListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class PublicFeedwallAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func feedwallListCall(
                        skip: Int,
                        limit: Int,
                        completion: @escaping FeedListCompletion) {
           let params = [
                "skip": skip,
                "limit": limit,
                "login_user_type" : "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getFeedList,
                       withParameters: params,
                       completion: completion)
       }
}
