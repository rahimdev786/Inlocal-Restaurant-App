//
//  MenuDetailDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol MenuDetailAPIResponseDelegate {
    func menuDetailSuccess(withData: MenuDetailResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}
//MenuDetailResponse
class MenuDetailDataManager: APIResponseHandler {
    
    var apiResponseDelegate: MenuDetailAPIResponseDelegate?
    lazy var localDataManager = MenuDetailLocalDataManager()
    lazy var apiDataManager = MenuDetailAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func menuDetailCall(menuItemId: Int, restaurantId: Int){
        
        apiDataManager.menuDetailCall(menuItemId: menuItemId,
                                      restaurantId: restaurantId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.menuDetailSuccess(withData: responseData!)
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
