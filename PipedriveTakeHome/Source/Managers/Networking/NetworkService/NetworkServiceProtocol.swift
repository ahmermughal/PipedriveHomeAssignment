//
//  NetworkServiceProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol{
    

    func performRequest<T:Decodable>(apiType: NetworkRouter, resultType: T.Type) -> AnyPublisher<T, NetworkError>
    
    
}
