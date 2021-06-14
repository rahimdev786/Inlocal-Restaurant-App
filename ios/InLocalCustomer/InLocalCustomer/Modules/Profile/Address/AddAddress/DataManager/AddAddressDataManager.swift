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
    
}

class AddAddressDataManager {
    
    var apiResponseDelegate: AddAddressAPIResponseDelegate?
    lazy var localDataManager = AddAddressLocalDataManager()
    lazy var apiDataManager = AddAddressAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
