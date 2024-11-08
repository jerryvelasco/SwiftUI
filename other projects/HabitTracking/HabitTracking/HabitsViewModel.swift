//
//  HabitsViewModel.swift
//  HabitTracking
//
//  Created by jerry on 11/8/24.
//

import Foundation

class HabitsViewModel: ObservableObject {
    
    //tries to load data
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([HabitData].self, from: savedHabits) {
                habitsList = decodedHabits
                return
            }
        }
        //if data cant be loaded
        habitsList = []
    }
    
    //tries to save data
    @Published var habitsList = [HabitData]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habitsList) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    static let SampleHabits = [
        HabitData(goal: "sample 1", description: "drink 8 glasses of water"),
        HabitData(goal: "sample 2", description: "workout 6 times a week"),
        HabitData(goal: "sample 3", description: "walk 8,000 steps a day")
    ]
}
