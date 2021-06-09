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
    
}

class CartDataManager {
    
    var apiResponseDelegate: CartAPIResponseDelegate?
    lazy var localDataManager = CartLocalDataManager()
    lazy var apiDataManager = CartAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
