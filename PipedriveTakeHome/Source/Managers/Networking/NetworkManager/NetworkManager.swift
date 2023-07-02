//
//  NetworkManager.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation
import Combine


class NetworkManager: NetworkManagerProtocol {
    
    // MARK: Variables
    /// Creates a static property named shared of type NetworkManager, ensuring that only one instance of NetworkManager is created.
    static let shared = NetworkManager()
    
    /// Creates a private constant named networkService of type NetworkService, which is an object that handles network requests.
    private let networkService = NetworkService()
    
    // MARK: Init
    private init() {}

    // MARK: Function
    
    /// It is used to query all the persons using the .getAllPerson api with the passed in page number.
    ///
    /// - Parameter page: page number used for pagination
    /// - Returns: A publisher with output type PersonsResponse and failure type NetworkError
    func getAllPersons(page: Int = 1) -> AnyPublisher<PersonsResponse, NetworkError> {

        /// Calls the performRequest method of the networkService object, passing an apiType value of .getAllPersons(page: page) and a resultType of PersonsResponse.self.
        return networkService.performRequest(apiType: .getAllPersons(page: page), resultType: PersonsResponse.self)
    }
    
}
