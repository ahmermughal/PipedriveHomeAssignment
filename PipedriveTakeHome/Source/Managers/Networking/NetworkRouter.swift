//
//  NetworkRouter.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation


enum NetworkRouter {
    
    
    case getAllPersons

    
    static let baseURL: String = "https://api.pipedrive.com/v1/"

    
    var path: String {
        switch self {
            
        case .getAllPersons:
            return "persons"
            
        }
    }
    
    private enum MethodType : String{
        
        /// The GET method is used to retrieve data from a server.
        case get = "GET"
        
        /// The PATCH method is used to make partial updates to a resource on a server.
        case patch = "PATCH"
        
        /// The POST method is used to submit data to a server for processing.
        case post = "POST"
        
        /// The UPDATE method is not a standard HTTP method. This case may be a typo or an unsupported custom method.
        case update = "UPDATE"
    }
    
    var method: String {
        switch self {
        case .getAllPersons:
            return MethodType.get.rawValue

        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllPersons:
            return ["api_token" : NetworkConstant.apiToken]
        }
    }
    
    var bodyData: Data?{
        switch self{
        case .getAllPersons:
            return nil
        }
    }
}
