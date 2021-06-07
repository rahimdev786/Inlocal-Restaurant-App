//
//  MenuDetailDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol MenuDetailAPIResponseDelegate {
    
}

class MenuDetailDataManager {
    
    var apiResponseDelegate: MenuDetailAPIResponseDelegate?
    lazy var localDataManager = MenuDetailLocalDataManager()
    lazy var apiDataManager = MenuDetailAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
