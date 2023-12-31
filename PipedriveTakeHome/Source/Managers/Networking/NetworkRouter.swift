//
//  NetworkRouter.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation

/// Defines an enumeration named `NetworkRouter`" with a case: `getAllPersons`, This enumeration is used to handle different API routes in a network layer of an application.
enum NetworkRouter {
    
    
    case getAllPersons(page: Int)

    // MARK: Base URL
    static let baseURL: String = "https://api.pipedrive.com/v1/"

    // MARK: Path
    /// Defines the end point of an API based on the current enum case
    var path: String {
        switch self {
            
        case .getAllPersons:
            return "persons"
            
        }
    }
    
    /// Enumeration to represent different HTTP methods.
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
    
    // MARK: - HTTPMethod
    /// Defines the methods type based on the current enum case
    var method: String {
        switch self {
        case .getAllPersons:
            return MethodType.get.rawValue

        }
    }
    
    // MARK: - Parameters
    /// Defines parameters an endpoint takes based on the current enum case.
    var parameters: [String: Any]? {
        switch self {
        case .getAllPersons(let page):
            return ["api_token" : NetworkConstant.apiToken,
                    "limit" : "\(NetworkConstant.personLimit)",
                    "start" : "\(((NetworkConstant.personLimit * page) - NetworkConstant.personLimit))" ]
        }
    }
    
    // MARK: - BodyData
    /// Defines the body data an API will have and encodes the given model passed in the case parameter to Data
    var bodyData: Data?{
        switch self{
        case .getAllPersons:
            return nil
        }
    }
}
