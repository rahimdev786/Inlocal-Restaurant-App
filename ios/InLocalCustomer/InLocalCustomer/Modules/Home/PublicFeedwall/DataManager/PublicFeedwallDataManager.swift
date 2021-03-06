//
//  PublicFeedwallDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

protocol PublicFeedwallAPIResponseDelegate {
    func storyFeedListSuccess(withData: StoryFeedwallListResponse)
    func feedListSuccess(withData: FeedWallListResponse)
    func postLikeSuccess(withData: EmptyResponse?)
    func postSaveSuccess(withData: EmptyResponse?)
    func apiError(_ error: APIError)
    func storyApiError(_ error: Error)
    func networkError(_ error: Error)
}

class PublicFeedwallDataManager: APIResponseHandler {
    
    var apiResponseDelegate: PublicFeedwallAPIResponseDelegate?
    lazy var localDataManager = PublicFeedwallLocalDataManager()
    lazy var apiDataManager = PublicFeedwallAPIDataManager()
    
    init() {
    }
    
    // Data fetch service methods goes here
    func feedwallListCall(skip: Int, limit: Int){
        
        apiDataManager.feedwallListCall(skip: skip,
                                        limit: limit) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.feedListSuccess(withData: responseData!)
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
    
    //storyFeedwallListCall
    func storyFeedwallListCall(skip: Int, limit: Int){
        
        apiDataManager.storyFeedwallListCall(skip: skip,
                                        limit: limit) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.storyFeedListSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }else{
                    welf.apiResponseDelegate?.apiError(responseError!)
                }
            } else if result.error {
                welf.apiResponseDelegate?.storyApiError(error!)
            } else {
                welf.apiResponseDelegate?.networkError(error!)
            }
        }
    }
    
    func postLikeCall(id: Int, likeStatus: String){
        
        apiDataManager.postLikeCall(id: id,
                                             likeStatus: likeStatus) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.postLikeSuccess(withData: responseData)
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
    
    func postSaveCall(id: Int, favoriteStatus: String){
        
        apiDataManager.postSaveCall(id: id,
                                    favoriteStatus: favoriteStatus) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.postSaveSuccess(withData: responseData)
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
