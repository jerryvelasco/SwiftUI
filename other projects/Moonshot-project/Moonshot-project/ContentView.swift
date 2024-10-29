//
//  ContentView.swift
//  Moonshot-project
//
//  Created by jerry on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    
    //decode missions and astronauts json file
    //type annotation is used to let swift know format of json files ahead of time 
    let missions: [Missions] = Bundle.main.decode("missions.json")
    let astronauts: [String : Astronauts] = Bundle.main.decode("astronauts.json")
    
    @State private var showListView = false
    @State private var buttonText = "list"
    @State private var buttonImage = "list.bullet"
    
    var body: some View {
        
        NavigationStack {
            
            //will show items in list when showListView else it'll show them in a grid
            Group {
                if showListView {
                    ListView(missions: missions, astronauts: astronauts)
                }
                else {
                    GridView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("missions")
            .preferredColorScheme(.light)
            .toolbar {
                ToolbarItem {
                    
                    //controls when to show list or grid layouts
                    Button(buttonText, systemImage: buttonImage) {
                        showListView.toggle()
                        
                        //changes button image and text 
                        buttonText = showListView ? "grid" : "list"
                        buttonImage = showListView ? "square.grid.2x2" : "list.bullet"
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

