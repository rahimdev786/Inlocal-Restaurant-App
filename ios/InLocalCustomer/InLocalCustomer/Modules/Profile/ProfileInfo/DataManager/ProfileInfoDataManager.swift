//
//  ProfileInfoDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol ProfileInfoAPIResponseDelegate: class {
}

class ProfileInfoDataManager {
    weak var apiResponseDelegate: ProfileInfoAPIResponseDelegate?
    lazy var localDataManager = ProfileInfoLocalDataManager()
    lazy var apiDataManager = ProfileInfoAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
