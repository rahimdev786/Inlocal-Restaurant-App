//
//  BottumTabBarDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol BottumTabBarAPIResponseDelegate {
    
}

class BottumTabBarDataManager {
    
    var apiResponseDelegate: BottumTabBarAPIResponseDelegate?
    lazy var localDataManager = BottumTabBarLocalDataManager()
    lazy var apiDataManager = BottumTabBarAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
