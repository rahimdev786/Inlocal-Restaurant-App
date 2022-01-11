//
//  OrderDetailsAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias orderDetailsCompletion = (_ successResponse: OrderDetailsDataClass?, _ errorResponse: APIError?, _ error: Error?) -> Void


class OrderDetailsAPIDataManager : APIDataManager {
    init() {
    }
    // Data fetch service methods goes here
    func getOrderDetails(orderId: Int,completion: @escaping orderDetailsCompletion) {
        let params = [
            "order_id": orderId
        ] as [String : Any]
        
        print(params)
        makeAPICall(to: OrderDetailsEndpoints.getOrderList,
                    withParameters: params,
                    completion: completion)
    }
}
