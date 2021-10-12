//
//  NotificationSettingsAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
//UpdateSettingResponse
typealias GetNotificationSettingCompletion = (_ successResponse: NotificationSettingResponseModel?, _ errorResponse: APIError?, _ error: Error?) -> Void
typealias UpdateSettingCompletion = (_ successResponse: UpdateSettingResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class NotificationSettingsAPIDataManager: APIDataManager {
    init() {
    }
    // Data fetch service methods goes here
    
    func getNotificationSettingCall(completion: @escaping GetNotificationSettingCompletion) {
          
        makeAPICall(to: NotificationEndpoints.getList,
                       withParameters: nil,
                       completion: completion)
    }
    
    func updateNotificationSettings(post: Bool, stories: Bool, comments: Bool, followers: Bool, orders: Bool, booking: Bool, payments: Bool, completion: @escaping UpdateSettingCompletion) {
           let params = [
            "post" : post,
            "stories" : stories,
            "comments" : comments,
            "followers" : followers,
            "orders" : orders,
            "bookings" : booking,
            "payment" : payments
            ] as [String : Any]
        
           print(params)
           makeAPICall(to: NotificationEndpoints.updateSetting,
                       withParameters: params,
                       completion: completion)
       }

}
