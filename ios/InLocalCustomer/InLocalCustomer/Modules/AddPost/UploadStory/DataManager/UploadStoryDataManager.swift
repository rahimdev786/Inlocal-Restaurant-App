//
//  UploadStoryDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 12/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol UploadStoryAPIResponseDelegate: class {
}

class UploadStoryDataManager {
    weak var apiResponseDelegate: UploadStoryAPIResponseDelegate?
    lazy var localDataManager = UploadStoryLocalDataManager()
    lazy var apiDataManager = UploadStoryAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
}
