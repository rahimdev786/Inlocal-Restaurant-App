//
//  ReservationDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ReservationAPIResponseDelegate {
    
}

class ReservationDataManager {
    
    var apiResponseDelegate: ReservationAPIResponseDelegate?
    lazy var localDataManager = ReservationLocalDataManager()
    lazy var apiDataManager = ReservationAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
