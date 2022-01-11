//
//  OrderDetailsDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol OrderDetailsAPIResponseDelegate: class {

    func apiError(_ error: APIError)
    func networkError(_ error: Error)
    func orderDetails(withData: OrderDetailsDataClass)
}

class OrderDetailsDataManager : APIResponseHandler {
    weak var apiResponseDelegate: OrderDetailsAPIResponseDelegate?
    lazy var localDataManager = OrderDetailsLocalDataManager()
    lazy var apiDataManager = OrderDetailsAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
    func orderDetail(orderId: Int){
        
        apiDataManager.getOrderDetails(orderId: orderId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.orderDetails(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    //welf.apiResponseDelegate?.showVerifyEmailScreen(responseError!)
                    welf.apiResponseDelegate?.apiError(responseError!)
                }else{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }
            } else if result.error {
                welf.apiResponseDelegate?.networkError(error!)
            } else {
                welf.apiResponseDelegate?.networkError(error!)
            }
        }
    }
}
