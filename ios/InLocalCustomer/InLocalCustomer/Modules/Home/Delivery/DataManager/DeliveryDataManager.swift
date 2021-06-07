//
//  DeliveryDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol DeliveryAPIResponseDelegate {
    
}

class DeliveryDataManager {
    
    var apiResponseDelegate: DeliveryAPIResponseDelegate?
    lazy var localDataManager = DeliveryLocalDataManager()
    lazy var apiDataManager = DeliveryAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
