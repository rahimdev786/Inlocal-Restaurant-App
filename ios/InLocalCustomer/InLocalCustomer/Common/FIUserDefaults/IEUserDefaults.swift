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
    private let PushToken = "PushToken"
    private let UserDetails = "UserDetails"
    private let NotificationSettings = "NotificationSettings"
    
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
    
    var pushToken: String?{
        get {
            return UserDefaults.standard.value(forKey: PushToken) as? String
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: PushToken)
            UserDefaults.standard.synchronize()
        }
    }
    
   var userDetails:User? {
        get{
            guard let data = UserDefaults.standard.object(forKey: UserDetails) as? String else {
                return nil
            }
            guard let userData = Mapper<User>().map(JSONString: data) else {
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
    
    var notificationSettings: NotificationSettings?{
        get{
            guard let data = UserDefaults.standard.object(forKey: NotificationSettings) as? String else{
                return nil
            }
            guard let settingData = Mapper<NotificationSettings>().map(JSONString: data) else{
                return nil
            }
            return settingData
        }
        
        set(newValue){
            if let jsonString = newValue?.toJSONString(prettyPrint: true){
                UserDefaults.standard.set(jsonString, forKey: NotificationSettings)
                UserDefaults.standard.synchronize()
            }
            
        }
        
    }
    
/*
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
