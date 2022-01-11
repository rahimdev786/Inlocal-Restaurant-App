//
//  OrderListAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation



typealias orderHistoryCompletion = (_ success: OrderListing?,_ apiError:APIError?,_ error:Error? ) -> Void


class OrderListAPIDataManager : APIDataManager{
    init() {
    }
    // Data fetch service methods goes here
    
    func getOrderList(skip:Int,startDate:String,endDate:String, completion : @escaping orderHistoryCompletion)
    {
        
        let requestBody:[String:Any] = ["limit": 50,
          "skip": skip,
          "dateRange": [
            "startDate": startDate,
            "endDate": endDate
          ]
        ]
        makeAPICall(to: OrderEndPoints.getOrderHistory, withParameters: requestBody, ofType: .httpBody, completion: completion)
    }
    
}
