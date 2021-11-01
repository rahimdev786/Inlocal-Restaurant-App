//
//  NotificationsAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias NotificationListCompletion = (_ successResponse: NotificationListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void
typealias ReadNotificationCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class NotificationsAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func getNotificationListCall(
                    skip: Int,
                    limit: Int,
                    completion: @escaping NotificationListCompletion) {
           let params = [
               "limit": limit,
               "skip": skip,
                "login_user_type" : "Customer"
               ] as [String : Any]
        
           print(params)
        makeAPICall(to: NotificationEndpoints.notificationList,
                       withParameters: params,
                       completion: completion)
       }
    
    func readNotificationCall(
        notificationId: Int,
                    completion: @escaping ReadNotificationCompletion) {
           let params = [
            "login_user_type" : "Customer",
            "notification_id" : notificationId
               ] as [String : Any]
        
           print(params)
        makeAPICall(to: NotificationEndpoints.reatNotification,
                       withParameters: params,
                       completion: completion)
       }
}
