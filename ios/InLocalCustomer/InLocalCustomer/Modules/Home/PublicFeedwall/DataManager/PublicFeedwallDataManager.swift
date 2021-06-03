//
//  PublicFeedwallDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol PublicFeedwallAPIResponseDelegate {
    
}

class PublicFeedwallDataManager {
    
    var apiResponseDelegate: PublicFeedwallAPIResponseDelegate?
    lazy var localDataManager = PublicFeedwallLocalDataManager()
    lazy var apiDataManager = PublicFeedwallAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
