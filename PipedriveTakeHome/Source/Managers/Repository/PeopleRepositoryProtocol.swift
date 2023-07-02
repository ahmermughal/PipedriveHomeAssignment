//
//  PeopleRepositoryProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation


/// This protocol is used to act as a blueprint for the class or struct that implements it.
/// It allows to write easily testable code as we can now mock the repository using this protocol
protocol PeopleRepositoryProtocol{
    
    /// Retreive list of all persons from repository
    /// - Returns: list of `Person` objects
    func getAllPerson() -> [Person]
    
}
