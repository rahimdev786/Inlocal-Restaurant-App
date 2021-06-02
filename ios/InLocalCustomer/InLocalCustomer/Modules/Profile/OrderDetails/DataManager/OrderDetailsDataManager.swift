//
//  OrderDetailsDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol OrderDetailsAPIResponseDelegate: class {
}

class OrderDetailsDataManager {
    weak var apiResponseDelegate: OrderDetailsAPIResponseDelegate?
    lazy var localDataManager = OrderDetailsLocalDataManager()
    lazy var apiDataManager = OrderDetailsAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
