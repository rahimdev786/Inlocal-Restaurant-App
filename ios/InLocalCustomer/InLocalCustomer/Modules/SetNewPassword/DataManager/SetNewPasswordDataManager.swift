//
//  SetNewPasswordDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SetNewPasswordAPIResponseDelegate {
    
}

class SetNewPasswordDataManager {
    
    var apiResponseDelegate: SetNewPasswordAPIResponseDelegate?
    lazy var localDataManager = SetNewPasswordLocalDataManager()
    lazy var apiDataManager = SetNewPasswordAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
