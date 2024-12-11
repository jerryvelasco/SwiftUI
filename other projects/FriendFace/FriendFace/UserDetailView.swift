//
//  UserDetailView.swift
//  FriendFace
//
//  Created by jerry on 12/10/24.
//
import SwiftUI

struct UserDetailView: View {
    
    let user: UserModel
    
    var body: some View {
        VStack{
            Text(user.initials)
                .font(.system(size: 100))
                .frame(width: 225, height: 225)
                .foregroundStyle(.white).bold()
                .background(LinearGradient(colors: [.gray.opacity(0.2), .gray], startPoint: .top, endPoint: .bottom))
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(user.isActive ? Color.blue : Color.clear, lineWidth: 1.0)
                }
                    .padding(.top,25)
            
            List {
                Section("account info") {
                    Text("Registered: \(user.formattedDate)")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("Employer: \(user.company)")
                }
                
                Section("About me") {
                    Text(user.about)
                }
                
                Section("friends") {
                    ForEach(user.friends) {
                        Text($0.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
