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
    func getNotificationSettingSuccess(withData: NotificationSettingResponseModel)
    func updateNotificationSuccess(withData: UpdateSettingResponse)
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}

class NotificationSettingsDataManager : APIResponseHandler {
    weak var apiResponseDelegate: NotificationSettingsAPIResponseDelegate?
    lazy var localDataManager = NotificationSettingsLocalDataManager()
    lazy var apiDataManager = NotificationSettingsAPIDataManager()
    init() {
    }
    
    // Data fetch service methods goes here
    func getNotificationSettingCall(){
        
        apiDataManager.getNotificationSettingCall() {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.getNotificationSettingSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    //welf.apiResponseDelegate?.showVerifyEmailScreen(responseError!)
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

    func updateNotificationSettings(post: Bool, stories: Bool, comments: Bool, followers: Bool, orders: Bool, booking: Bool, payments: Bool){
        
        apiDataManager.updateNotificationSettings(post: post, stories: stories, comments: comments, followers: followers, orders: orders, booking: booking, payments: payments) {[weak self] (responseData, responseError, error) in
                                        
                                        
            guard let welf = self else { return }
           
            let result = welf.verifyResponse(response: (responseData, responseError, error))
            
            if result.success {
                welf.apiResponseDelegate?.updateNotificationSuccess(withData: responseData!)
            } else if result.errorResponse {
                if responseError!.rawValue == 1002{
                    //welf.apiResponseDelegate?.showVerifyEmailScreen(responseError!)
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
