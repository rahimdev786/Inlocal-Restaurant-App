//
//  RestaurantInfoDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol RestaurantInfoAPIResponseDelegate {
    
}

class RestaurantInfoDataManager {
    
    var apiResponseDelegate: RestaurantInfoAPIResponseDelegate?
    lazy var localDataManager = RestaurantInfoLocalDataManager()
    lazy var apiDataManager = RestaurantInfoAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
