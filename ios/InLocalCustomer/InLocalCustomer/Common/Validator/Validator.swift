//
//  Validator.swift
//  BeautyTouch
//
//  Created by Arijit Sarkar on 06/10/17.
//  Copyright © 2017 Innofied. All rights reserved.
//


import Foundation

let emailRegEx =  "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
                    "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                    "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                    "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                    "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                    "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
                    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"

public enum ValidationType {
    
    case nonEmptyString
    case name
    case email
    case password
    case loginPassword
    case phoneNumber
    case otp
    case match(referenceItem: String)
    case emailOrPhoneNumber
    case nameOremailOrPhoneNumber
    
    var nameString: String {
        switch self {
        case .nonEmptyString: return ""
        case .name: return "Name"
        case .email: return "Email"
        case .password: return "Password"
        case .loginPassword: return "Password"
        case .phoneNumber: return "Mobile Number"
        case .otp: return "OTP"
        case .match: return "Confirm Password"
        case .emailOrPhoneNumber: return ""
        case .nameOremailOrPhoneNumber: return ""
        }
    }
    
    var regex: String {
        switch self {
        case .nonEmptyString: return "^(?!\\s*$).+"
        case .name: return "^[a-zA-Z ]*$"//"^([a-zA-z]+\\s?)*\\s*$"//"^[\\p{L} .'-]+$"
        case .email: return emailRegEx//"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case .password: return "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        //case .password: return "^(?=.*\\d)[A-Za-z0-9\\d$@$!%*#?&]{8,}$"
        //case .password : return "^[a-zA-Z0-9d$@$!%*#?&]{6,}$"
        case .loginPassword: return "^(?!\\s*$).+"
        case .phoneNumber: return "\\d{8,10}"//"\\d{10}"//"^[0-9+]{0,1}+[0-9]{5,16}$"
        //case .phoneNumber: return "^[0-9+]{0,1}+[0-9]{5,16}$"
        //case .otp: return "^\\d{4}$"
        case .otp: return "^\\d{6}$"
        case .match(let referenceItem): return referenceItem
        case .emailOrPhoneNumber: return "([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,})|(\\d{8,11})"
        case .nameOremailOrPhoneNumber: return "([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,})|(\\d{8,11})|(^[\\p{L} .'-]+$)"
            
        }
    }
    
    var errorMessage: String {
        switch self {
        case .nonEmptyString: return AppConstants.ErrorMessage.BlankField
        case .name: return AppConstants.ErrorMessage.NameValidationError
        case .email: return AppConstants.ErrorMessage.EmailValidationError
        case .password: return AppConstants.ErrorMessage.PasswordValidationError
        case .loginPassword: return "Password" + " " + AppConstants.ErrorMessage.BlankField
        case .phoneNumber: return AppConstants.ErrorMessage.MobileNumberValidationError
        case .otp: return AppConstants.ErrorMessage.OTPValidationError
        case .match: return AppConstants.ErrorMessage.ConfirmPasswordValidationError
        case .emailOrPhoneNumber: return "Provide valid email or phone number"
        case .nameOremailOrPhoneNumber: return "Provide valid name or email or phone number"
        }
    }
}

struct Validator {
    
    enum Result {
        case valid
        case invalid(isBlankField: Bool, errMsg: String)
    }
    
    static func isValid(itemToValidate: String, validationType: ValidationType) -> Bool {
        return true
        let test = NSPredicate(format: "SELF MATCHES %@", validationType.regex)
        return test.evaluate(with: itemToValidate)
    }
    
    static func validate(itemToValidate: String, validationType: ValidationType, completion: (Result) -> Void) {
        
        // Validation for non-empty string
        let nonEmptyStringTest = NSPredicate(format: "SELF MATCHES %@", ValidationType.nonEmptyString.regex)
        let isNonEmpty = nonEmptyStringTest.evaluate(with: itemToValidate)
        if !isNonEmpty {
            completion(.invalid(isBlankField: true, errMsg: ValidationType.nonEmptyString.errorMessage))
            return
        }
        
        // Validation depending on Validation type provided
        let fieldSpecificTest = NSPredicate(format: "SELF MATCHES %@", validationType.regex)
        let isValid = fieldSpecificTest.evaluate(with: itemToValidate)
        if isValid {
            completion(.valid)
        } else {
            completion(.invalid(isBlankField: false, errMsg: validationType.errorMessage))
        }
    }
}
