//
//  SignupDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SignupAPIResponseDelegate {
    
}

class SignupDataManager {
    
    var apiResponseDelegate: SignupAPIResponseDelegate?
    lazy var localDataManager = SignupLocalDataManager()
    lazy var apiDataManager = SignupAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
