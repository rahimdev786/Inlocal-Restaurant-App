//
//  ChangePasswordDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ChangePasswordAPIResponseDelegate {
    
}

class ChangePasswordDataManager {
    
    var apiResponseDelegate: ChangePasswordAPIResponseDelegate?
    lazy var localDataManager = ChangePasswordLocalDataManager()
    lazy var apiDataManager = ChangePasswordAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
