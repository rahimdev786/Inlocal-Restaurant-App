//
//  ValidateOTPDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ValidateOTPAPIResponseDelegate {
    
}

class ValidateOTPDataManager {
    
    var apiResponseDelegate: ValidateOTPAPIResponseDelegate?
    lazy var localDataManager = ValidateOTPLocalDataManager()
    lazy var apiDataManager = ValidateOTPAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
