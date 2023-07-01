//
//  PersonDetailViewModel.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation


class PersonDetailViewModel {
    
    let person : Person
    var contactList : [(title: String, contact: [PersonContact])]  = []
    
    init(person: Person) {
        self.person = person
        setupContactList()
    }
    
    func setupContactList() {
        
        
        let phoneNumbers = person.getPhoneNumbers()
        let emails = person.getEmails()
        
        if !phoneNumbers.isEmpty {
            contactList.append((title: StringConstant.phone, contact: person.phone))
        }
        
        if !emails.isEmpty {
            contactList.append((title: StringConstant.email, contact: person.email))
        }
        
    }
    
}
