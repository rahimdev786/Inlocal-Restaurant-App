//
//  BookingListDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol BookingListAPIResponseDelegate: class {
}

class BookingListDataManager {
    weak var apiResponseDelegate: BookingListAPIResponseDelegate?
    lazy var localDataManager = BookingListLocalDataManager()
    lazy var apiDataManager = BookingListAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
