//
//  IEUserDefaults.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import Foundation
import LanguageManager_iOS
import ObjectMapper

enum SelectedLanguage {
    case Arabic
    case English
    
    var lngName: String{
        switch self {
        case .Arabic:
            return "ar"
        case .English:
            return "en"
        
        }
    }
    
}

class IEUserDefaults{
    static let shared = IEUserDefaults()
    private let Language = "Language"
    private let ApiToken = "ApiToken"
    private let UserDetails = "UserDetails"
    private let TotalCartCount = "TotalCartCount"
    private let PushToken = "PushToken"
    private let NotificationCount = "NotificationCount"
    private let GLobalURLs = "GLobalURLs"
    private let CartID = "CartId"
    private let social = "Social"
    

    var socialLogin: Bool?{
        get {
            return UserDefaults.standard.bool(forKey: social)
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: social)
            UserDefaults.standard.synchronize()
        }
    }
    
    var pushToken: String?{
        get {
            return UserDefaults.standard.value(forKey: PushToken) as? String
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: PushToken)
            UserDefaults.standard.synchronize()
        }
    }
    
    var notificationCount: Int?{
        get {
            return UserDefaults.standard.value(forKey: NotificationCount) as? Int
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: NotificationCount)
            UserDefaults.standard.synchronize()
        }
    }
    
    var selectedLanguage: String?{
        get{
            return UserDefaults.standard.value(forKey: Language) as? String
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Language)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var apiToken: String?{
        get{
            return UserDefaults.standard.value(forKey: ApiToken) as? String
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: ApiToken)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var totalCartCount: Int? {
       get{
           return UserDefaults.standard.value(forKey: TotalCartCount) as? Int
       }
       set(newValue){
           UserDefaults.standard.set(newValue, forKey: TotalCartCount)
           UserDefaults.standard.synchronize()
       }
   }
    
    var cartID: Int? {
        get{
            return UserDefaults.standard.value(forKey: CartID) as? Int
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: CartID)
            UserDefaults.standard.synchronize()
        }
    }
/*
   var userDetails:CustomerDetails? {
        get{
            guard let data = UserDefaults.standard.object(forKey: UserDetails) as? String else {
                return nil
            }
            guard let userData = Mapper<CustomerDetails>().map(JSONString: data) else {
                return nil
            }
            return userData
        }
        set(newValue){
            if let jsonString = newValue?.toJSONString(prettyPrint: true) {
            //Store in UserDefaults
                UserDefaults.standard.set(jsonString, forKey: UserDetails)
                UserDefaults.standard.synchronize()
            }
        }
    }
    

    var globalUrls: Urls?{
        get{
            guard let data = UserDefaults.standard.object(forKey: GLobalURLs) as? String else {
                return nil
            }
            guard let userData = Mapper<Urls>().map(JSONString: data) else {
                return nil
            }
            return userData
        }
        set(newValue){
            if let jsonString = newValue?.toJSONString(prettyPrint: true) {
            //Store in UserDefaults
                UserDefaults.standard.set(jsonString, forKey: GLobalURLs)
                UserDefaults.standard.synchronize()
            }
        }
    }
 */
}
