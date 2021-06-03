//
//  ViewStoryDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ViewStoryAPIResponseDelegate {
    
}

class ViewStoryDataManager {
    
    var apiResponseDelegate: ViewStoryAPIResponseDelegate?
    lazy var localDataManager = ViewStoryLocalDataManager()
    lazy var apiDataManager = ViewStoryAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
