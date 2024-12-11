//
//  UserModel.swift
//  FriendFace
//
//  Created by jerry on 12/10/24.
//

import Foundation
import SwiftData

@Model
class UserModel: Identifiable, Codable, Hashable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let friends: [FriendModel]
    
    //describe which keys should be encoded/decoded
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case friends
    }
    
    //use decoder instance to try and read the properties
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)         //reads all possible keys that can be loaded from the JSON
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        
        let stringDate = try container.decode(String.self, forKey: .registered)     //reads a string from the registered key
        
        self.registered = ISO8601DateFormatter().date(from: stringDate) ?? .now     //converts the string into a ISO8601 date and assigns it to the local registered property
        
        self.friends = try container.decode([FriendModel].self, forKey: .friends)
    }
    
    //uses encoder instance to try and write our properties to it
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)     //creates place to write our CodingKeys values to
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(ISO8601DateFormatter().string(from: self.registered), forKey: .registered) //converts the local registered ISO8601 date back to a string to keep the JSON existing format and writes that value to the CodingKeys
        try container.encode(self.friends, forKey: .friends)
    }
    
    //formats the date 
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
    
    //gets the initials from the name
    var initials: String {
        let splitName = name.split(separator: " ")
        var letters = ""
        
        for i in Range(0...splitName.count - 1) {
            letters += String(splitName[i].first ?? "?")
        }
        
        return letters
    }
}
