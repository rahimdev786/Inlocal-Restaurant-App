//
//  AppConstants.swift
//  BeautyTouch
//
//  Created by Arijit Sarkar on 06/10/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {}

extension AppConstants {
    struct ErrorMessage {
        static let BlankField = "*Required"
        static let InvalidFormat = "Invalid format."
        static let NameValidationError = "A name must only contain alphabets."
        static let EmailValidationError = "Please provide a valid email address."
        //static let PasswordValidationError = "The password must contain a minimum of 8 characters and atleast a single number."
        static let PasswordValidationError = "The password must be eight or more characters long and must include one symbol."
        static let MobileNumberValidationError = "Please provide a valid mobile number."
        static let ConfirmPasswordValidationError = "The re-entered password does not match with one provided above."
        static let OTPValidationError = "OTP should contain only 6 digits."
        
    }
    
    
    struct ApiDateFormat{
        static let apiFormat = "yyyy-MM-dd HH:mm:ss"
        static let reviewDateFormat = "dd MMM yyyy"
        static let notificationDateFormat = "E, dd MMM yyyy"
        static let deliveredDateFormat = "dd MMM yyyy '|' HH:mm"
        static let timeFormat = "HH:mm a"
        static let pickupDateFormat = "dd-MM-yyyy hh:mm a"
        static let storeTimeFormat = "dd-MM-yyyy HH:mm:ss"

        static let pickupDayFormat = "dd MMMM yyyy, EEEE"
        static let storeDateTimeFormat = "dd-MM-yyyy hh:mm a"
        static let addtoCartDateFormat = "yyyy-MM-dd"
        static let deliveryDateFormat = "dd-MM-yyyy"


    }
    
    struct Measurement {
        static let metersInAMile = 1609.0
    }
     
    struct LocationConstants {
        static let locationUploadIntervalSeconds = 10.0
    }
    
   
    struct GoogleApiKey {
        //AIzaSyAmRgOdAMdM30qunmrNXeAPSKF4UosMp3s - client
        static let key = "AIzaSyAmRgOdAMdM30qunmrNXeAPSKF4UosMp3s"
        //AIzaSyBqpDxl2numcwKfv_DFMv0eNfXDx6H7es4 - personal
        static let clientID = "847201034324-brajnnirrmggkt43oqldneg0eeqg09m0.apps.googleusercontent.com"
    }
    
    struct StripeKey {
        
        static let key = "pk_test_51GrzMGGwaq2nvPcKdzBAfD2gtym8u2gXjMsD7Ii1FTeBsVT5FSpkH3fU3ygGA59InVwRlsU2BcAKlcETFGXoqjNf00lun2NytD"
    }
    
//    struct GoogleClientId {
//        static let key = "965027002688-ihh527a5tf9a8n7tc48decacdptnpldh.apps.googleusercontent.com"
//    }
    
    struct FbAppId {
        static let appID = "379738473005873"
    }
    
    struct TwitterKeys {
        static let apiKey = "7Y7rg4xC7784on0r2sWL0bu0w"
        static let apiSecretKey = "iqzf754VRLfrjxi8TtXz7x4UlD8C2bZS5fz6Z13z1P3po1UUzJ"
    }
    
//    struct BaseUrl {
//        static let url = "http://34.238.160.179/flickit/backend/public/api/user"
//    }
    struct ApiKey {
        static let key = "iSeWmr/fThje632IhneuCeIIr/hA4tAIafa0yI8bLcTgO7tvrEYoK"
    }
    
    struct Currency {
        static let dollar = "$"
    }
}

//let arrColors = [UIColor(hexString: "#42cef5"), UIColor(hexString: "#ba93d9"), UIColor(hexString: "#df4ef5"), UIColor(hexString: "#c0d48c"), UIColor(hexString: "#03801c"), UIColor(hexString: "#f26c24"), UIColor(hexString: "#f72302"), UIColor(hexString: "#0411c7"), UIColor(hexString: "#42cef5"), UIColor(hexString: "#ba93d9"), UIColor(hexString: "#df4ef5"), UIColor(hexString: "#c0d48c"), UIColor(hexString: "#03801c"), UIColor(hexString: "#f26c24"), UIColor(hexString: "#f72302"), UIColor(hexString: "#0411c7")]
let EMPTY_TVC_HEIGHT = CGFloat(200)

let PAGINATION_LIMIT = 5
let DEFAULT_COUNTRY_CODE = "US"

let REFRESH_RATE_IN_SEC = 300.0// #Testing make it 300


var isMemberShipPlanAlertPresented = false

