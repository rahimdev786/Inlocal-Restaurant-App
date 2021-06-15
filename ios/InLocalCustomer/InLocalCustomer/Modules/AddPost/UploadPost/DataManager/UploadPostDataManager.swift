//
//  UploadPostDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 15/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol UploadPostAPIResponseDelegate: class {
}

class UploadPostDataManager {
    weak var apiResponseDelegate: UploadPostAPIResponseDelegate?
    lazy var localDataManager = UploadPostLocalDataManager()
    lazy var apiDataManager = UploadPostAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
