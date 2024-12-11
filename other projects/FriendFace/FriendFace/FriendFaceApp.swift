//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by jerry on 12/10/24.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: UserModel.self)
    }
}
