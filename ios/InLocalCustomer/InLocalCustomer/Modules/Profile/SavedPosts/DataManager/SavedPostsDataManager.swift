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
    func getSavedPostSuccess(withData: SavedPostResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class SavedPostsDataManager: APIResponseHandler {
    weak var apiResponseDelegate: SavedPostsAPIResponseDelegate?
    lazy var localDataManager = SavedPostsLocalDataManager()
    lazy var apiDataManager = SavedPostsAPIDataManager()
    init() {
    }
    // Data fetch service methods goes here
    func getSavedPostCall(skip: Int, limit: Int, loginUserType: String){
        
        apiDataManager.getSavedPostCall(skip: skip, limit: limit, loginUserType: loginUserType) {[weak self] (responseData, responseError, error) in
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.getSavedPostSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }else{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }
            } else if result.error {
                welf.apiResponseDelegate?.networkError(error!)
            } else {
                welf.apiResponseDelegate?.networkError(error!)
            }
        }
    }
}
