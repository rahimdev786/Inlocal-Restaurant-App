//
//  AddressBookAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias AddressCompletionCompletion = (_ successResponse: AddressBookResponseModel?, _ errorResponse: APIError?, _ error: Error?) -> Void
typealias SetDefaultAddressCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class AddressBookAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func getAddressListCall(
                    skip: Int,
                    limit: Int,
                    completion: @escaping AddressCompletionCompletion) {
           let params = [
               "limit": limit,
               "skip": skip,
               ] as [String : Any]
        
           print(params)
        makeAPICall(to: AddressEndpoints.addressList,
                       withParameters: params,
                       completion: completion)
       }
    
    func setDefaultAddressCall(
                    addressId: Int,
                    completion: @escaping SetDefaultAddressCompletion) {
           let params = [
               "id": addressId
               ] as [String : Any]
        
           print(params)
        makeAPICall(to: AddressEndpoints.setDefaultAddress,
                       withParameters: params,
                       completion: completion)
       }
}
