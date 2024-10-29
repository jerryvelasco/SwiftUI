//
//  AstronautView.swift
//  Moonshot-project
//
//  Created by jerry on 10/26/24.
//

import SwiftUI

/*
 view will show more info for each astronaut selected in missionview
 */
struct AstronautView: View {
    
    //gives astronaut type annotation of Astronauts instance
    //declared already in the contentview
    let astronaut: Astronauts
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text(astronaut.description)
                        .padding()
                }
                .navigationTitle(astronaut.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    let astronaut: [String:Astronauts] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astronaut: astronaut["aldrin"]!)
}
