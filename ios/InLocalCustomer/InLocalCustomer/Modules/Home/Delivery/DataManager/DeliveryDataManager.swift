//
//  DeliveryDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol DeliveryAPIResponseDelegate: APIResponseHandler {
    func menuCategoryListSuccess(withData: MenuCategoryListResponse)
    func menuListSuccess(withData: MenuListResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class DeliveryDataManager: APIResponseHandler{
    
    var apiResponseDelegate: DeliveryAPIResponseDelegate?
    lazy var localDataManager = DeliveryLocalDataManager()
    lazy var apiDataManager = DeliveryAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func menuCategoryListCall(skip: Int, limit: Int, restaurantId: Int){
        
        apiDataManager.menuCategoryListCall(skip: skip,
                                            limit: limit,
                                            restaurantId: restaurantId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.menuCategoryListSuccess(withData: responseData!)
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
    
    func menuListCall(skip: Int, limit: Int, restaurantId: Int, menuCategoryId: Int, deliveryAvailable: Int, eatInsideAvailable: Int){
        
        apiDataManager.menuListCall(skip: skip,
                                    limit: limit,
                                    restaurantId: restaurantId,
                                    menuCategoryId: menuCategoryId,
                                    deliveryAvailable: deliveryAvailable,
                                    eatInsideAvailable: eatInsideAvailable) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.menuListSuccess(withData: responseData!)
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
