//
//  ErrorProtocol.swift
//  InLocalCustomer
//
//  Created by Innofied on 11/01/22.
//

import Foundation

protocol ErrorProtocol {
    func apiError(_ error: APIError)
    func networkError(_ error: Error)
}
