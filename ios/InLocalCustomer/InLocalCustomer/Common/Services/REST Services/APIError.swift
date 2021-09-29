//
//  APIError.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import Foundation
import UIKit

enum APIError: Int, Error{
    
    case code201 = 201
    case code401 = 401

    case code405 = 405
    case code501 = 501
    
    case code700 = 700
    case code701 = 701
    case code702 = 702

    case code710 = 710
    
    case code800 = 800
    case code801 = 801
    case code803 = 803
    case code804 = 804
    case code809 = 809
    case code810 = 810
    
    case code901 = 901
    case code902 = 902
    case code903 = 903
    case code904 = 904
    case code905 = 905
    case code906 = 906
    case code910 = 910
    case code908 = 908
    case code955 = 955

    case code1000 = 1000
    case code1001 = 1001
    case code1002 = 1002
    case code1005 = 1005
    case code1007 = 1007
    case code1008 = 1008
    case code1020 = 1020
    case code1050 = 1050
    case code1051 = 1051
    case noInternet = -1009
    case timeOut = -1001
    case code608 = 608
    
    case UNKNOWN_ERROR =  402

}

extension APIError: LocalizedError{
     public var errorDescription: String? {
        switch self {
        case .code201:
            return "code201".localiz()
        case .code401:
            return "code401".localiz()
        case .code501:
            return "code501".localiz()
        case .code700:
            return "code700".localiz()
        case .code701:
            return "code701".localiz()
        case .code702:
            return "code702".localiz()
        case .code710:
            return "code710".localiz()
        case .code800:
            return "code800".localiz()
        case .code801:
            return "code801".localiz()
        case .code803:
            return "code803".localiz()
        case .code804:
            return "code804".localiz()
        case .code809:
            return "code809".localiz()
        case .code901:
            return "code901".localiz()
        case .code902:
            return "code902".localiz()
        case .code903:
            return "code903".localiz()
        case .code904:
            return "code904".localiz()
        case .code905:
            return "code905".localiz()
        case .code906:
            return "code906".localiz()
        case .code908:
            return "code908".localiz()
        case .code910:
            return "code910".localiz()
        case .code1000:
             return "code1000".localiz()
        case .code1001:
            return "code1001".localiz()
        case .code1002:
            return "code1002".localiz()
        case .code1005:
            return "code1005".localiz()
        case .code1007:
            return "code1007".localiz()
        case .code1008:
            return "code1008".localiz()
        case .code1020:
            return "code1020".localiz()
        case .code1050:
            return "code1050".localiz()
        case .code1051:
            return "code1051".localiz()
        case .UNKNOWN_ERROR:
            return "UNKNOWN_ERROR".localiz()
        case .code955:
            return "code955".localiz()
        case.code608:
            return "code608".localiz()
        case .code405:
            return "".localiz()
        case .code810:
            return "code810".localiz()
            

        default:
            return "SomethingWentWrong"
        }
    }
}


