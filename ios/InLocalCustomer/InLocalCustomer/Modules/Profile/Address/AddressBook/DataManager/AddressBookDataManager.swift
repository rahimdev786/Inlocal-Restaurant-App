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
    
}

class AddressBookDataManager {
    
    var apiResponseDelegate: AddressBookAPIResponseDelegate?
    lazy var localDataManager = AddressBookLocalDataManager()
    lazy var apiDataManager = AddressBookAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
