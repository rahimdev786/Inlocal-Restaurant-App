//
//  SavedPostsDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol SavedPostsAPIResponseDelegate: class {
}

class SavedPostsDataManager {
    weak var apiResponseDelegate: SavedPostsAPIResponseDelegate?
    lazy var localDataManager = SavedPostsLocalDataManager()
    lazy var apiDataManager = SavedPostsAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
