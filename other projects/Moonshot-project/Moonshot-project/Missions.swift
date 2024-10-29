//
//  missions.swift
//  Moonshot-project
//
//  Created by jerry on 10/24/24.
//

import Foundation

//matches the format from the missions json
//codable allows for the json file to be decoded
struct Missions: Codable, Identifiable {
    
    //nested struct holds the list of the astronauts that took part of said mission
    //matching the missions json
    struct CrewMembers: Codable {
        let name: String
        let role: String
    }
    
    //properties match items in missions json file
    let id: Int
    let launchDate: Date?
    let description: String
    let crew: [CrewMembers]
    
    //returns the image name using the id 
    var imageName: String {
        return "apollo\(id)"
    }
    
    //returns the mission name using the id
    var missionName: String {
        return "Apollo \(id)"
    }
    
    //returns the launch date formatted
    var formattedLaunchDate: String {
        
        return launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
