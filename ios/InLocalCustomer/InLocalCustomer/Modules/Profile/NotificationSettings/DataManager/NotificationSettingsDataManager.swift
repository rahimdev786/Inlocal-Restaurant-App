//
//  NotificationSettingsDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol NotificationSettingsAPIResponseDelegate: class {
}

class NotificationSettingsDataManager {
    weak var apiResponseDelegate: NotificationSettingsAPIResponseDelegate?
    lazy var localDataManager = NotificationSettingsLocalDataManager()
    lazy var apiDataManager = NotificationSettingsAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
