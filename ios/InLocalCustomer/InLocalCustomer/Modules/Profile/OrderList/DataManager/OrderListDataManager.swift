//
//  OrderListDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation



protocol OrderListAPIResponseDelegate: class,ErrorProtocol {
    func orderListfetched(orderList:OrderListing?)
    
}

class OrderListDataManager : APIResponseHandler {
    weak var apiResponseDelegate: OrderListAPIResponseDelegate?
    lazy var localDataManager = OrderListLocalDataManager()
    lazy var apiDataManager = OrderListAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
    
    func getOrderList(skip:Int,startDate:String,endDate:String)
    {
        self.apiDataManager.getOrderList(skip: skip, startDate: startDate, endDate: endDate) { [weak self](orderListData, apiError, requesterror) in
            guard let welf = self else{
                return
            }
            
            let result = welf.verifyResponse(response: (orderListData, apiError, requesterror))
            
            DispatchQueue.main.async {
                if result.success {
                    welf.apiResponseDelegate?.orderListfetched(orderList: orderListData)
                } else if result.errorResponse {
                 
                   welf.apiResponseDelegate?.apiError(apiError!)
                } else if result.error {
                    welf.apiResponseDelegate?.networkError(requesterror!)
                } else {
                    welf.apiResponseDelegate?.networkError(requesterror!)
                }
                
            }
            
        }
    }
    
}
