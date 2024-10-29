//
//  ListView.swift
//  Moonshot-project
//
//  Created by jerry on 10/25/24.
//

import SwiftUI

/*
 creates the list view used in the initial screen
 */
struct ListView: View {
    
    //creates instances of the missions and astronauts struct
    //already declared in the contentview
    let missions: [Missions]
    let astronauts: [String:Astronauts]
    
    var body: some View {

        List {
            ForEach(missions, id:\.id) { mission in
                
                NavigationLink {
                    
                    //will provide more info on each mission
                    //passes in the mission tapped and astronaut struct
                    MissionView(mission: mission, astronauts: astronauts)
                    
                } label: {
                    
                    //creates image, names, dates using the computed properties in the missions struct
                    VStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 105, height: 105)
                            .padding()
                        
                        VStack {
                            Text(mission.missionName)
                                .font(.headline)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                        }
                        .foregroundStyle(.black)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Rectangle()
                                .foregroundStyle(Color.black.opacity(0.1))
                        )
                    }
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                }
            }
            .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String : Astronauts] = Bundle.main.decode("astronauts.json")
    
    return ListView(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.light)
}
