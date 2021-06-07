//
//  UserProfileDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol UserProfileAPIResponseDelegate {
    
}

class UserProfileDataManager {
    
    var apiResponseDelegate: UserProfileAPIResponseDelegate?
    lazy var localDataManager = UserProfileLocalDataManager()
    lazy var apiDataManager = UserProfileAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
