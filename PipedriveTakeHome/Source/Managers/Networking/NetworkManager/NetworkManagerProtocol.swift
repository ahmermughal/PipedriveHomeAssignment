//
//  NetworkManagerProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation


import Foundation
import Combine


/// This protocol is used to act as a blueprint for the class or struct that implements it.
/// It allows to write easily testable code as we can now mock the manager using this protocol
protocol NetworkManagerProtocol{
    
    /// It is used to query all the persons using the .getAllPerson api with the passed in page number.
    ///
    /// - Parameter page: page number used for pagination
    /// - Returns: A publisher with output type PersonsResponse and failure type NetworkError
    func getAllPersons(page: Int) -> AnyPublisher<PersonsResponse, NetworkError>


  
}
