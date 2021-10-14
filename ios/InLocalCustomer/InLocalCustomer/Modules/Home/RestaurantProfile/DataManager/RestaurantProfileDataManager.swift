//
//  RestaurantProfileDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol RestaurantProfileAPIResponseDelegate {
    func restaurantDetailSuccess(withData: RestaurentDetailResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class RestaurantProfileDataManager: APIResponseHandler {
    
    var apiResponseDelegate: RestaurantProfileAPIResponseDelegate?
    lazy var localDataManager = RestaurantProfileLocalDataManager()
    lazy var apiDataManager = RestaurantProfileAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func restaurentDetailsCall(restaurantId: Int){
        
        apiDataManager.restaurentDetailsCall(restaurantId: restaurantId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.restaurantDetailSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
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
