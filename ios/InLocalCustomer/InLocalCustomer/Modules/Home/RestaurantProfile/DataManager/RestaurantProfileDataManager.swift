//
//  RestaurantProfileDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol RestaurantProfileAPIResponseDelegate {
    
}

class RestaurantProfileDataManager {
    
    var apiResponseDelegate: RestaurantProfileAPIResponseDelegate?
    lazy var localDataManager = RestaurantProfileLocalDataManager()
    lazy var apiDataManager = RestaurantProfileAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
