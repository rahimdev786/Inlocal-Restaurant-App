//
//  AddAddressDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol AddAddressAPIResponseDelegate {
    func addAddressSuccess(withData: AddAddressResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class AddAddressDataManager : APIResponseHandler {
    
    var apiResponseDelegate: AddAddressAPIResponseDelegate?
    lazy var localDataManager = AddAddressLocalDataManager()
    lazy var apiDataManager = AddAddressAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func addAddressCall(address: String, landmark: String, zipcode: String, city: String, countryCode: String, country: String, latitude: String, longitude: String){
        
        apiDataManager.addAddressCall(address: address, landmark: landmark, zipcode: zipcode, city: city, countryCode: countryCode, country: country, latitude: latitude, longitude: longitude) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.addAddressSuccess(withData: responseData!)
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
