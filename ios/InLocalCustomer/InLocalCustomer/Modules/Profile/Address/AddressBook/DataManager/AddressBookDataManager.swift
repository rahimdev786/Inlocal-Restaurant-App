//
//  AddressBookDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol AddressBookAPIResponseDelegate {
    func addressListSuccess(withData: AddressBookResponseModel)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class AddressBookDataManager : APIResponseHandler {
    
    var apiResponseDelegate: AddressBookAPIResponseDelegate?
    lazy var localDataManager = AddressBookLocalDataManager()
    lazy var apiDataManager = AddressBookAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func getAddressListCall(token: String){
        
        apiDataManager.getAddressListCall(token: token) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.addressListSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    //welf.apiResponseDelegate?.showVerifyEmailScreen(responseError!)
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
