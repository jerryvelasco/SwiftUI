//
//  HabitData.swift
//  HabitTracking
//
//  Created by jerry on 11/6/24.
//

import Foundation

struct HabitData: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    let goal: String
    var completedCount: Int = 0
    let description: String
}
