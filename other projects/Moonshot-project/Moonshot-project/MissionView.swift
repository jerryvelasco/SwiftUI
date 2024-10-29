//
//  MissionView.swift
//  Moonshot-project
//
//  Created by jerry on 10/24/24.
//

import SwiftUI

/*
 provides more info for each mission
 */
struct MissionView: View {
    
    //instance gives access to badge image and mission name
    let mission: Missions
    let astronauts: [String:Astronauts]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    //badge images
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal){ size, axis in
                            size * 0.6
                        }
                    
                    VStack(alignment:.leading) {
                        
                        //creates line break below badge
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.black.opacity(0.5))
                            .padding(.vertical)
                        
                        Text("mission highlights:")
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text(mission.description)
                            .padding(.bottom)
                        
                        Text("crew:")
                            .font(.title.bold())
                    }
                    
                    //horizontal scroll view of astronauts
                    AstronautHorizontalScrollView(mission: mission, missionCrew: astronauts)
                }
                .padding()
            }
            .navigationTitle(mission.missionName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let mission:[Missions] = Bundle.main.decode("missions.json")
    let astronaut: [String:Astronauts] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: mission[0], astronauts: astronaut)
}
