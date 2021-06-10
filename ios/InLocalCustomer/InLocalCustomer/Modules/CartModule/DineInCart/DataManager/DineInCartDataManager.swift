//
//  DineInCartDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 10/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol DineInCartAPIResponseDelegate {
    
}

class DineInCartDataManager {
    
    var apiResponseDelegate: DineInCartAPIResponseDelegate?
    lazy var localDataManager = DineInCartLocalDataManager()
    lazy var apiDataManager = DineInCartAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
