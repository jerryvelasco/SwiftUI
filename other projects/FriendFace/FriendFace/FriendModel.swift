//
//  FriendModel.swift
//  FriendFace
//
//  Created by jerry on 12/10/24.
//

import Foundation
import SwiftData

@Model
class FriendModel: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name )
    }
}
