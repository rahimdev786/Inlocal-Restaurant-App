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
    func editProfileSuccess(withData: EditProfileResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class EditProfileDataManager : APIResponseHandler {
    weak var apiResponseDelegate: EditProfileAPIResponseDelegate?
    lazy var localDataManager = EditProfileLocalDataManager()
    lazy var apiDataManager = EditProfileAPIDataManager()
    init() {
    }
    
    // Data fetch service methods goes here
    func editUserProfileCall(fullname : String, email : String, phone : String){
        
        apiDataManager.editUserProfileCall(fullname : fullname, email : email, phone : phone) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.editProfileSuccess(withData: responseData!)
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
