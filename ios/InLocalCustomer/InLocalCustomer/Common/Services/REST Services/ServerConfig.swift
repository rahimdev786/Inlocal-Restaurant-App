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
        case authToken = "x-auth-token"
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
            HeaderKeys.pushToken.rawValue : "asdssa",
            HeaderKeys.authToken.rawValue : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYmZhNWNjMjc0YWIyZjAwOTQwNzg4ZWQyNTQ5MDNjOTEyNjllNjVmZDg4ODc1MTIwZGU4ZDAxYmM2YmRjYmRiNmQ0ZmQ3Yzk4ZTlkNGJhNjEiLCJpYXQiOjE2MzM1MTQ3NTMuMDkxNDg0LCJuYmYiOjE2MzM1MTQ3NTMuMDkxNDksImV4cCI6MTY2NTA1MDc1My4wNzk1NTEsInN1YiI6IjExIiwic2NvcGVzIjpbXX0.idLJIq8mS0WlptlX317Z4pKEHlExeDlP_qo-sQDonj85bIy-gqkz-8dxI7vWBN0mlL4U52j5e_0_dnLwqlCJkblzU9YC93oZwdxzvtbsUFCV-GK8s2VeSDppki3XleRF7we7HIlxHT9ZYCLZwFKZaYuvtdxcVkWfGgXubEA8Tf0RhG0fNr7LGRp7tRGSgIIRUInwapwkZz5wi3172Dyr-ahmpKAiOBpD_4eOqPlI65kklAiapBZt_a7BQBgdpVqZOH2ip3ynhKCkFA-6FsI602xjjQwxzkSAu3g57wtdcbrfUHlhG9APUwG0rb4r2lQ8UrhOZpFc6HcTRS7o5U4QSH2DK6ovh7qtqxm7aQY4JuWeKLQi3qrxz-4C_UEjeOkYvGHwispj3CjKYsyJgzoHwJuDmi8L-Dwozf-PLyphehT5FMrEGLFhVkx4mltAr9otq1AdOEWNkZzNf-FLM8snte6OZ0X00Ccusm_TFOj8KATnvFZv5GwmkcRdjv5nlMZ-QwDZEbCbJPX-hHFqiuCt4KhqiL8QgbsSirnQTpdeqDMTn4S_u_99edTBUkgoZrLRQJyJxPUEDklAmBCljcFrfz73266A96VSNDc254XypRLub8gC0m7ssmMybo3nopFN37YaMCm5P1qQDzXt_VHl1B2Iqo7Rl38UulqfVx6wDh8"
        ]
        /*
        if let authToken = authToken {
            headerDict[HeaderKeys.authToken.rawValue] = "Bearer \(authToken)"
        }
        */
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
