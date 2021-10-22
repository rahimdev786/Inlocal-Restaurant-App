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
    func commentListSuccess(withData: CommentListResponse)
    func addCommentSuccess(withData: EmptyResponse?)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class CommentDataManager : APIResponseHandler {
    
    var apiResponseDelegate: CommentAPIResponseDelegate?
    lazy var localDataManager = CommentLocalDataManager()
    lazy var apiDataManager = CommentAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func commentListCall(skip: Int, limit: Int, postId: Int){
        
        apiDataManager.commentListCall(skip: skip,
                                       limit: limit,
                                       postId: postId) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.commentListSuccess(withData: responseData!)
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
    
    func addCommentCall(postId: Int, message: String){
        
        apiDataManager.addCommentCall(postId: postId,
                                      message: message) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.addCommentSuccess(withData: responseData)
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
