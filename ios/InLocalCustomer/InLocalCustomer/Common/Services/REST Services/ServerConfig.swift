//
//  ServerConfig.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//


import Foundation
import Alamofire


enum APIMode {
    
    case localDevelopment
    case production
    case qa
    case development
}

struct ServerConfig {
    
    // MARK: - Static stored properties
    static var baseURL = "http://ec2-3-0-166-170.ap-southeast-1.compute.amazonaws.com/inlocal-restaurant-nfc-app/api"
    static var mqttURL = ""
    static var mqttPort = UInt16()
    
    // MARK: Setting mode changes the stored URLs
    static var mode: APIMode = .localDevelopment {
        
        didSet {
            
            switch mode {
                
            case .localDevelopment:
                baseURL = "http://ec2-3-0-166-170.ap-southeast-1.compute.amazonaws.com/inlocal-restaurant-nfc-app/api"
                //mqttURL = "192.168.0.33"
                //mqttPort = 1883
                
            case .production:
                baseURL = "http://13.235.136.143:7000/api/v1"
                //mqttURL = ""
               // mqttPort = 1883
                
            case .qa:
                baseURL = "http://13.235.136.143:7000/api/v1"
               // mqttURL = ""
                //mqttPort = 1883
                
            case .development:
                baseURL = "https://insta-express.com/staging/rest/V1"//"http://insta-express.com/rest/V1"//client server url
                //mqttURL = ""
                //mqttPort = 1883
            }
        }
    }
    
    // MARK: - Initializer
    init(withMode mode: APIMode) {
        ServerConfig.mode = mode
    }
}

struct APIHeader {
    
    internal enum HeaderKeys: String {
        
        case contentType = "Content-Type"
        case uuid = "x-auth-deviceid"
        case deviceType = "x-auth-devicetype"
        case pushToken = "x-auth-notificationkey"
        case authToken = "Authorization"
    }
    
    static let shared = APIHeader()
    
    var uuidString: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    var pushToken: String? {
        return IEUserDefaults.shared.pushToken
    }
    
    var authToken: String? {
        return IEUserDefaults.shared.apiToken
    }
    
    var myCartId: Int? {
        return IEUserDefaults.shared.cartID
    }
    
    var headers: [String: String] {
        
        
        var headerDict = [
            //HeaderKeys.contentType.rawValue: "application/json",
            //HeaderKeys.accept.rawValue: "application/json",
            HeaderKeys.uuid.rawValue: uuidString,
            HeaderKeys.deviceType.rawValue: "1",
            HeaderKeys.pushToken.rawValue : "asdssa"
        ]
        
        if let authToken = authToken {
            headerDict[HeaderKeys.authToken.rawValue] = "Bearer \(authToken)"
        }
        
        return headerDict
    }
    
   /* var multipartHeaders: HTTPHeaders {
        
        var headerDict = [
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)",
            HeaderKeys.accept.rawValue: "application/json",
            HeaderKeys.uuid.rawValue: uuidString,
            HeaderKeys.deviceType.rawValue: "2"
        ]
        
        if let pushToken = pushToken {
            headerDict[HeaderKeys.pushToken.rawValue] = pushToken
        }
        
        if let authToken = authToken {
            headerDict[HeaderKeys.authToken.rawValue] = authToken
        }
        
//        if let langKey = langKey {
//            headerDict[HeaderKeys.language.rawValue] = langKey
//        }
        
        return headerDict
    }*/
}
