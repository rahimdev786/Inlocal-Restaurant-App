//
//  FollowerDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol FollowerAPIResponseDelegate: class {
}

class FollowerDataManager {
    weak var apiResponseDelegate: FollowerAPIResponseDelegate?
    lazy var localDataManager = FollowerLocalDataManager()
    lazy var apiDataManager = FollowerAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
