//
//  RestaurantMenuDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol RestaurantMenuAPIResponseDelegate {
    
}

class RestaurantMenuDataManager {
    
    var apiResponseDelegate: RestaurantMenuAPIResponseDelegate?
    lazy var localDataManager = RestaurantMenuLocalDataManager()
    lazy var apiDataManager = RestaurantMenuAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
