//
//  RestaurantProfileAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias RestaurantDetailCompletion = (_ successResponse: RestaurentDetailResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void
typealias RestaurantPostListCompletion = (_ successResponse: RestaurantPostResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class RestaurantProfileAPIDataManager: APIDataManager{

    init() {
    }
    
    // Data fetch service methods goes here
    func restaurentDetailsCall(restaurantId: Int,
                        completion: @escaping RestaurantDetailCompletion) {
           let params = [
                "restaurant_id": restaurantId,
                "login_user_type" : "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getRestaurentDeatils,
                       withParameters: params,
                       completion: completion)
    }
    
    
    func restaurentPostListCall(restaurantId: Int,
                                skip: Int,
                                limit: Int,
                        completion: @escaping RestaurantPostListCompletion) {
           let params = [
                "skip": skip,
                "limit": limit,
                "restaurant_id": restaurantId,
                "login_user_type": "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getRestaurantPostList,
                       withParameters: params,
                       completion: completion)
    }
}
