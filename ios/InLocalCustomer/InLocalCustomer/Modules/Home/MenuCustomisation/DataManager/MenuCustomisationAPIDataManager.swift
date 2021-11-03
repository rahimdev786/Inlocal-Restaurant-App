//
//  MenuCustomisationAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 11/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias AddToCartCompletion = (_ successResponse: AddToCartResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class MenuCustomisationAPIDataManager : APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func addToCartCall(
        restaurantId: Int, menuItemId: Int, menuItemName: String, price: Double, quantity: Int, subaddon: [Dictionary<String, Any>],
                    completion: @escaping AddToCartCompletion) {
           let params = [
            "restaurant_id": restaurantId,
            "menu_item_id": menuItemId,
            "menu_item_name" : menuItemName,
            "price" : price,
            "qty" : quantity,
            "subaddon" : subaddon
            ] as [String : Any]
        
           print(params)
        makeAPICall(to: HomeEndpoints.addToCart,
                       withParameters: params,
                       completion: completion)
       }
}

