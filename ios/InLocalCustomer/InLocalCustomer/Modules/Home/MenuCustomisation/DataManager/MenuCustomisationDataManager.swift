//
//  MenuCustomisationDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 11/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol MenuCustomisationAPIResponseDelegate {
    
}

class MenuCustomisationDataManager {
    
    var apiResponseDelegate: MenuCustomisationAPIResponseDelegate?
    lazy var localDataManager = MenuCustomisationLocalDataManager()
    lazy var apiDataManager = MenuCustomisationAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
