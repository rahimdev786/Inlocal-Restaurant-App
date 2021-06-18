//
//  PaymentTypeDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol PaymentTypeAPIResponseDelegate {
    
}

class PaymentTypeDataManager {
    
    var apiResponseDelegate: PaymentTypeAPIResponseDelegate?
    lazy var localDataManager = PaymentTypeLocalDataManager()
    lazy var apiDataManager = PaymentTypeAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
