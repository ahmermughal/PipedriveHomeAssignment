//
//  NetworkServiceProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation
import Combine

/// This protocol is used to act as a blueprint for the class or struct that implements it.
/// It allows to write easily testable code as we can now mock the service using this protocol
protocol NetworkServiceProtocol{
    

    func performRequest<T:Decodable>(apiType: NetworkRouter, resultType: T.Type) -> AnyPublisher<T, NetworkError>
    
    
}
