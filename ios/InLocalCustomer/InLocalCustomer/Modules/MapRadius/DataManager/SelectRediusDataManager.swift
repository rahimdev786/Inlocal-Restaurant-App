//
//  SelectRediusDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SelectRediusAPIResponseDelegate {
    
}

class SelectRediusDataManager {
    
    var apiResponseDelegate: SelectRediusAPIResponseDelegate?
    lazy var localDataManager = SelectRediusLocalDataManager()
    lazy var apiDataManager = SelectRediusAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
