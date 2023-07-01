//
//  PersonDetailViewModel.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation


struct PersonDetailViewModel{
    
    let person : Person
    
    
    
    var contactList : [(title: String, contact: [PersonContact])] {
        
        var contactDataArr : [(title: String, contact: [PersonContact])] = []
        
        let phoneNumbers = person.getPhoneNumbers()
        let emails = person.getEmails()
        
        if !phoneNumbers.isEmpty {
            contactDataArr.append((title: StringConstant.phone, contact: person.phone))
        }
        
        if !emails.isEmpty {
            contactDataArr.append((title: StringConstant.email, contact: person.email))
        }
        
        return contactDataArr
    }
    
}
