//
//  SigninDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SigninAPIResponseDelegate {
    
}

class SigninDataManager {
    
    var apiResponseDelegate: SigninAPIResponseDelegate?
    lazy var localDataManager = SigninLocalDataManager()
    lazy var apiDataManager = SigninAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
