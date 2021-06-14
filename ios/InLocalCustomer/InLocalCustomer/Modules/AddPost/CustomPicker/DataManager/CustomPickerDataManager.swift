//
//  CustomPickerDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol CustomPickerAPIResponseDelegate: class {
}

class CustomPickerDataManager {
    weak var apiResponseDelegate: CustomPickerAPIResponseDelegate?
    lazy var localDataManager = CustomPickerLocalDataManager()
    lazy var apiDataManager = CustomPickerAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
