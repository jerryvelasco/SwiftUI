//
//  GridView.swift
//  Moonshot-project
//
//  Created by jerry on 10/25/24.
//

import SwiftUI

/*
 holds the grid layout for initial screen
 */
struct GridView: View {
    
    //controls grid layout
    //will try and fit as many items that can fit in a spacing min of 150
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    //missions and astronauts instances were already declared in contentview
    let missions: [Missions]
    let astronauts: [String:Astronauts]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                
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
                                
                                //light background shade over mission name and launchdate
                                Rectangle()
                                    .foregroundStyle(Color.black.opacity(0.1))
                            )
                        }
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
        }
    }
}


#Preview {
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String : Astronauts] = Bundle.main.decode("astronauts.json")
    
    return GridView(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.light)
}
