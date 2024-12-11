//
//  ContentView.swift
//  FriendFace
//
//  Created by jerry on 12/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var filterBy = ""            //shows all UserModels by default 
    @State private var sortOrder = [            //sort UserModels by name
        SortDescriptor(\UserModel.name)
    ]
    
    var body: some View {
        NavigationStack {
            
            UserListView(filterBy: filterBy, sortOrder: sortOrder)
                .navigationTitle("friend face")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    Menu("filter", systemImage: "arrow.up.arrow.down") {
                        Button("Show All") {
                            filterBy = "All"
                        }
                        
                        Button("Online") {
                            filterBy = "Online"
                        }
                        
                        Button("Offline") {
                            filterBy = "Offline"
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
