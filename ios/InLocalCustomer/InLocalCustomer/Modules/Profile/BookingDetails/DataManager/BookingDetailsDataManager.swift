//
//  BookingDetailsDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol BookingDetailsAPIResponseDelegate: class {
}

class BookingDetailsDataManager {
    weak var apiResponseDelegate: BookingDetailsAPIResponseDelegate?
    lazy var localDataManager = BookingDetailsLocalDataManager()
    lazy var apiDataManager = BookingDetailsAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
