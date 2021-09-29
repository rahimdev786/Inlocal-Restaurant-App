//
//  JsonResponseError.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import Foundation

enum JsonResponseError: Error {
    case unexpectedResponse
    case unreachableNetwork
    case sessionOut
}

extension JsonResponseError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
        case .unexpectedResponse:
            return "Oops! Received an unexpected response from the server."
        case .unreachableNetwork:
            return "We're sorry, an internet connection could not be established."
        case .sessionOut:
            return "Session expired. Please login again."
        }
    }
}
