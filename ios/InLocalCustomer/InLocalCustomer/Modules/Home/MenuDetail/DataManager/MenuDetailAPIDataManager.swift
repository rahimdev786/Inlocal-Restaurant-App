//
//  MenuDetailAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias MenuDetailCompletion = (_ successResponse: MenuDetailResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class MenuDetailAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func menuDetailCall(
                    menuItemId: Int,
                    restaurantId: Int,
                    completion: @escaping MenuDetailCompletion) {
           let params = [
               "menu_item_id": menuItemId,
               "restaurant_id": restaurantId
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.menuDetail,
                       withParameters: params,
                       completion: completion)
       }
}
