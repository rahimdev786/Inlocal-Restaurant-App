//
//  DeliveryAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class DeliveryAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func menuCategoryListCall(
                    skip: Int,
                    limit: Int,
                    restaurantId: Int,
                    completion: @escaping MenuCategoryListCompletion) {
           let params = [
               "limit": limit,
               "skip": skip,
                "restaurant_id": restaurantId
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.menuCategoryList,
                       withParameters: params,
                       completion: completion)
       }
    
    func menuListCall(
                    skip: Int,
                    limit: Int,
                    restaurantId: Int,
                    menuCategoryId: Int,
                    deliveryAvailable: Int,
                    eatInsideAvailable: Int,
                    completion: @escaping MenuListCompletion) {
           
        let params = [
                "limit": limit,
                "skip": skip,
                "restaurant_id": restaurantId,
                "menu_category_id" : menuCategoryId,
                "DeliveryAvailable" : deliveryAvailable,
                "eatInsideAvailable" : eatInsideAvailable
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.menuList,
                       withParameters: params,
                       completion: completion)
       }
}
