//
//  CartDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol CartAPIResponseDelegate {
    func cartListSuccess(withData: CartListResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class CartDataManager : APIResponseHandler{
    
    var apiResponseDelegate: CartAPIResponseDelegate?
    lazy var localDataManager = CartLocalDataManager()
    lazy var apiDataManager = CartAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func cartListCall(cartId: Int){
        
        apiDataManager.cartListCall(cartId: cartId) {[weak self] (responseData, responseError, error) in
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.cartListSuccess(withData: responseData!)
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
