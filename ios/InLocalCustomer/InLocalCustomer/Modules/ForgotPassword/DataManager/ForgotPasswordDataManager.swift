//
//  ForgotPasswordDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ForgotPasswordAPIResponseDelegate {
    
}

class ForgotPasswordDataManager {
    
    var apiResponseDelegate: ForgotPasswordAPIResponseDelegate?
    lazy var localDataManager = ForgotPasswordLocalDataManager()
    lazy var apiDataManager = ForgotPasswordAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
