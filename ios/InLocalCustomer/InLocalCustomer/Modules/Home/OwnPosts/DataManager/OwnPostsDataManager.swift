//
//  OwnPostsDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 05/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol OwnPostsAPIResponseDelegate {
    
}

class OwnPostsDataManager {
    
    var apiResponseDelegate: OwnPostsAPIResponseDelegate?
    lazy var localDataManager = OwnPostsLocalDataManager()
    lazy var apiDataManager = OwnPostsAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
