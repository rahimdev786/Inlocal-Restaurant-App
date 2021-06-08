//
//  CommentDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol CommentAPIResponseDelegate {
    
}

class CommentDataManager {
    
    var apiResponseDelegate: CommentAPIResponseDelegate?
    lazy var localDataManager = CommentLocalDataManager()
    lazy var apiDataManager = CommentAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
}
