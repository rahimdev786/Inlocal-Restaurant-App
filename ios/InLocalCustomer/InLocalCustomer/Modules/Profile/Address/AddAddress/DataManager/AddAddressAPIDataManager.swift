//
//  AddAddressAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias AddAddressCompletionCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class AddAddressAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func addAddressCall(
        address: String, landmark: String, zipcode: String, city: String, countryCode: String, country: String, latitude: String, longitude: String,
                    completion: @escaping AddAddressCompletionCompletion) {
           
        let params = [
            "address": address,
            "landmark": landmark,
            "zipcode" : zipcode,
            "city" : city,
            "country_code" : countryCode,
            "country" : country,
            "latitude" : latitude,
            "longitude" : longitude
            ] as [String : Any]
        
           print(params)
        makeAPICall(to: AddressEndpoints.addAddress,
                       withParameters: params,
                       completion: completion)
       }
}

