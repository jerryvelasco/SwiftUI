//
//  Astronauts.swift
//  Moonshot-project
//
//  Created by jerry on 10/24/24.
//

import Foundation

//matches the format of the astronauts json 
struct Astronauts: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
