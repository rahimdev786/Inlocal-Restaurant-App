//
//  TagedPhotosDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol TagedPhotosAPIResponseDelegate {
    
}

class TagedPhotosDataManager {
    
    var apiResponseDelegate: TagedPhotosAPIResponseDelegate?
    lazy var localDataManager = TagedPhotosLocalDataManager()
    lazy var apiDataManager = TagedPhotosAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
