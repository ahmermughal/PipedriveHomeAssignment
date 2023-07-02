//
//  PersistenceServiceProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation

/// This protocol is used to act as a blueprint for the class or struct that implements it.
/// It allows to write easily testable code as we can now mock the service using this protocol
protocol PersistenceServiceProtocol {
    
    /// Saves the provided list of people to UserDefaults.
    ///
    /// - Parameter list: The list of people to be saved.
    func savePeopleList(list: [Person])
    
    /// Retrieves the list of people from UserDefaults.
    ///
    /// - Returns: The list of people, or an empty array if retrieval fails.
    func getPeopleList() -> [Person]
}
