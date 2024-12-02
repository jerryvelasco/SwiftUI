//
//  iExpense_projectApp.swift
//  iExpense-project
//
//  Created by jerry on 12/2/24.
//

import SwiftData
import SwiftUI

@main
struct iExpense_projectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseModel.self)
    }
}
