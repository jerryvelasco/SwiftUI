//
//  UserListView.swift
//  FriendFace
//
//  Created by jerry on 12/10/24.
//

import SwiftData
import SwiftUI

struct UserListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var users: [UserModel]
    
    init(filterBy: String, sortOrder: [SortDescriptor<UserModel>]) {
        _users = Query(filter: #Predicate<UserModel> { user in
            
            //will either show all UserModels or certain UserModels based on if their active or not
            if filterBy == "Online" {
                return user.isActive
            }
            else if filterBy == "Offline" {
                return !user.isActive
            }
            else {
                return user.isActive || !user.isActive
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack {
                    Text(user.initials)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(.white).bold()
                        .background(LinearGradient(colors: [.gray.opacity(0.2), .gray], startPoint: .top, endPoint: .bottom))
                        .clipShape(Circle())
                    
                    VStack(alignment:.leading) {
                        Text(user.name)
                            .bold()
                        
                        Text(user.isActive ? "Online" : "Offline")
                            .foregroundStyle(user.isActive ? .blue : .secondary)
                    }
                    .padding(.leading, 25)
                }
            }
        }
        .navigationDestination(for: UserModel.self, destination: { user in
            UserDetailView(user: user)
        })
        .task {
            
            //only runs if there no UserModel isntances in the array
            if users.isEmpty {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601         //matches date formatting from the JSON
        
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            
            if let decodeData = try decoder.decode([UserModel]?.self, from: data) {
                
                //inserts each instance one at a time to the model context
                for user in decodeData {
                    modelContext.insert(user)
                }
            }
        } catch {
            print("Unable to decode data: \(error.localizedDescription)")
            return
        }
    }
}

#Preview {
    UserListView(filterBy: "All", sortOrder: [SortDescriptor(\UserModel.name)])
}
