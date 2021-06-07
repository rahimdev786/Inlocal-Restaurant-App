//
//  EditProfileDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol EditProfileAPIResponseDelegate: class {
}

class EditProfileDataManager {
    weak var apiResponseDelegate: EditProfileAPIResponseDelegate?
    lazy var localDataManager = EditProfileLocalDataManager()
    lazy var apiDataManager = EditProfileAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
