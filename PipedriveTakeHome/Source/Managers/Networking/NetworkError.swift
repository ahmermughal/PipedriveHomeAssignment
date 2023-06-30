//
//  NetworkError.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation


enum NetworkError: Swift.Error {
    case someError
    case noInternet
    case invalidURL
    case badRequest
    case dataParseError
    case invalidData
}
