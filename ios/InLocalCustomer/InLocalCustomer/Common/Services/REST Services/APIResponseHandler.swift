//
//  APIResponseHandler.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//


import Foundation
import ObjectMapper

typealias GenericAPIResponseResult<T: BaseMappable> = (successResponse: T?, errorResponse: APIError?, error: Error?)
typealias GenericAPIArrayResponseResult<T: BaseMappable> = (successResponse: [T]?, errorResponse: APIError?, error: Error?)
typealias GenericAPIVerificationResult = (success: Bool, errorResponse: Bool, error: Bool)

protocol APIResponseHandler: class {
    
}

extension APIResponseHandler {
    
    func verifyResponse<T: BaseMappable>(response: GenericAPIResponseResult<T>) -> GenericAPIVerificationResult{
        
        if response.successResponse == nil &&
            response.errorResponse == nil &&
            response.error == nil {
            return (true, false, false)
        }
        
        if response.successResponse != nil {
            return (true, false, false)
        } else {
            if let errorResponse = response.errorResponse {
                switch errorResponse {
                // case .SESSION_NOT_FOUND,.USER_HAS_BEEN_SUSPENDED:
                case .code1050:
                    //                    AppDelegate.shared?.scrapUserDetails()
                    //                    AppDelegate.shared?.moveToHome(target: nil)
                    //                    AppDelegate.shared?.window?.makeToast(errorResponse.errorDescription)
                    
                    ()
                    
                default:
                    break
                }
                return (false, true, false)
            } else if let _ = response.error {
                if response.error as? JsonResponseError == JsonResponseError.sessionOut || response.error?.asAFError?.responseCode == 401  {
                    //AppDelegate.shared?.scrapUserDetails()
                    //AppDelegate.shared?.moveToHome(target: nil)
                    AppDelegate.shared.window?.makeToast("Session expired. Please login again")
                }
                //                else if let error = response.error?.asAFError?.underlyingError as? NSError {
                //                    if error.code == -1009 {
                //                        AppDelegate.shared.window?.makeToast("No Internet Connection")
                //                    } else if error.code == -1001 {
                //                        AppDelegate.shared.window?.makeToast("Request time out")
                //                    }
                //                }
                return (false, false, true)
            } else {
                return (false, false, true)
            }
        }
    }
}
