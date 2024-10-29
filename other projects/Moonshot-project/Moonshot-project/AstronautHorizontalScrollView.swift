//
//  AstronautHorizontalScrollView.swift
//  Moonshot-project
//
//  Created by jerry on 10/29/24.
//

import SwiftUI

struct AstronautHorizontalScrollView: View {
    
    //creates link between the astronauts json and the missions json
    struct MissionCrew {
        let astronauts: Astronauts
        let role: String
    }
    
    //custom initialzer changes the missionCrew parameter to match the format from the astronuats json
    init(mission: Missions, missionCrew: [String:Astronauts]) {
        self.mission = mission
        
        //based on the mission selected uses the map function to loop through the mission.crew array in missions json
        self.missionCrew = mission.crew.map({ crewMember in
            
            //compares the names from the mission.crew array from the missions json
            //with the keys in the missionCrew dictionary from the astronauts json
            if let astronaut = missionCrew[crewMember.name] {
                
                //creates a new instances of the astronauts that match
                return MissionCrew(astronauts: astronaut, role: crewMember.role)
            }
            else {
                
                //if no matching strings are found the app will crash
                fatalError("\(crewMember.name) is missing")
            }
        })
    }
    
    //instance gives access to badge image and mission name
    let mission: Missions
    
    //array holds all of the matching astronauts found in both json files
    let missionCrew: [MissionCrew]
    
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                
                //loops through the array of astronauts found in both jsons
                ForEach(missionCrew, id:\.role) { astronaut in
                    
                    NavigationLink {
                        
                        //view provides more info for each astronaut
                        //passes in the astronauts struct gaining access to the astronauts json
                        AstronautView(astronaut: astronaut.astronauts)
                        
                    } label: {
                        
                        //horizontail scroll view showing each astronauts img, name and role
                        HStack(spacing: 0) {
                            
                            Image(astronaut.astronauts.id)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 100)
                                .clipShape(Circle())
                                .padding(.vertical)
                            
                            VStack(alignment:.leading) {
                                Text(astronaut.astronauts.name)
                                Text(astronaut.role)
                                    .shadow(radius: 0)
                            }
                            .foregroundStyle(.black)
                            Spacer(minLength: 15.0)
                        }
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0.0, y: 0.0)
                    }
                    .padding()
                }
            }
        }
    }}

#Preview {
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String:Astronauts] = Bundle.main.decode("astronauts.json")
    
    return AstronautHorizontalScrollView(mission: missions[0], missionCrew: astronauts)
}
