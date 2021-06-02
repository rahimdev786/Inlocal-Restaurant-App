//
//  NotificationsDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol NotificationsAPIResponseDelegate {
    
}

class NotificationsDataManager {
    
    var apiResponseDelegate: NotificationsAPIResponseDelegate?
    lazy var localDataManager = NotificationsLocalDataManager()
    lazy var apiDataManager = NotificationsAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
