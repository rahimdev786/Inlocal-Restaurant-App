//
//  CartAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias CartCompletion = (_ successResponse: CartListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class CartAPIDataManager : APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func cartListCall(
                    cartId: Int,
                    completion: @escaping CartCompletion) {
           let params = [
               "cart_id": cartId
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.getCart,
                       withParameters: params,
                       completion: completion)
       }
}
