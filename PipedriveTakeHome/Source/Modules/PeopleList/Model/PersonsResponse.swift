//
//  PersonsResponse.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation


struct PersonsResponse : Codable{
    
    let success : Bool
    let data : [Person]
    let additionalData : AdditionalData?
    
    enum CodingKeys: String, CodingKey{
        case success
        case data
        case additionalData = "additional_data"
    }
}

struct Person : Codable, Hashable {
   
    let id : Int
    let name : String?
    let organizationName : String?
    let phone : [PersonContact]
    let email : [PersonContact]
    let picture : PersonPicture?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case organizationName = "org_name"
        case phone
        case email
        case picture = "picture_id"
    }
    
    func getPhoneNumbers()->[PersonContact]{
        var phoneList : [PersonContact] = []
        
        for item in self.phone{
            if !(item.value?.isEmpty ?? false){
                phoneList.append(item)
            }
        }
        return phoneList
    }
    
    func getEmails()->[PersonContact]{
        var emailList : [PersonContact] = []
        
        for item in self.email{
            if !(item.value?.isEmpty ?? false){
                emailList.append(item)
            }
        }
        return emailList
    }
}

struct PersonContact : Codable, Hashable {
    
    let label : String?
    let value : String?
    let isPrimary : Bool?
    
    enum CodingKeys: String, CodingKey{
        case label
        case value
        case isPrimary = "primary"
    }
    
}

struct PersonPicture : Codable, Hashable {
    
    let pictures : PictureItem?
    
}

struct PictureItem : Codable, Hashable {
    
    let smallImage : String?
    let largeImage : String?
    
    enum CodingKeys: String, CodingKey{
        case smallImage = "128"
        case largeImage = "512"
    }
    
    
}

struct AdditionalData : Codable {
    let pagination : PaginationData
}

struct PaginationData : Codable {
    let start : Int
    let limit : Int
    let anyMoreItem : Bool
    
    enum CodingKeys: String, CodingKey{
        case start
        case limit
        case anyMoreItem = "more_items_in_collection"
    }
}
