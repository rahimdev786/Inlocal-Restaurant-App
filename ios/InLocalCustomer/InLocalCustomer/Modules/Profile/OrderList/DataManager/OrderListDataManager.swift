//
//  OrderListDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol OrderListAPIResponseDelegate: class {
}

class OrderListDataManager {
    weak var apiResponseDelegate: OrderListAPIResponseDelegate?
    lazy var localDataManager = OrderListLocalDataManager()
    lazy var apiDataManager = OrderListAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
