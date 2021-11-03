//
//  MenuCustomisationDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 11/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol MenuCustomisationAPIResponseDelegate {
    func addToCartSuccess(withData: AddToCartResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class MenuCustomisationDataManager : APIResponseHandler{
    
    var apiResponseDelegate: MenuCustomisationAPIResponseDelegate?
    lazy var localDataManager = MenuCustomisationLocalDataManager()
    lazy var apiDataManager = MenuCustomisationAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func addToCartCall(restaurantId: Int, menuItemId: Int, menuItemName: String, price: Double, quantity: Int, subaddon: [Dictionary<String, Any>]){
        
        apiDataManager.addToCartCall(restaurantId: restaurantId, menuItemId: menuItemId, menuItemName: menuItemName, price: price, quantity: quantity, subaddon: subaddon) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.addToCartSuccess(withData: responseData!)
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
