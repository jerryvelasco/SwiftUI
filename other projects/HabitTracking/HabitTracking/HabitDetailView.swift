//
//  HabitDetailView.swift
//  HabitTracking
//
//  Created by jerry on 11/7/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var habitsViewModel: HabitsViewModel
    
    @State var habit: HabitData
    @State var completed: Int
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(habit.goal.capitalized)
                    .font(.title).bold()
                
                Text(habit.description.capitalized)
                
                Rectangle()
                    .frame(width: 250, height: 2).bold()
    
                HStack {
                    Text("Completed Goal: \(completed)x")
                    
                    //allows for count to be subtracted from
                    Button {
                        decrementCompleted()
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    .tint(.red)
                    //buttons disabled if the count is set to 0 
                    .disabled(completed == 0)
                }
                
                Text("Tap Button Upon Finishing Activity!")
                
                Button {
                    incrementCompleted()
                } label: {
                    Text("Done!")
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(Capsule())
                }
            }
            .FormBackgroundStyle()
        }
        .padding()
        .navigationTitle("Activity Detail")
        .navigationBarTitleDisplayMode(.inline)
        
        Spacer()
    }
    
    func decrementCompleted() {
        completed -= 1
        
        //creates a new goal with after subtracting 1 from the completed count
        let decrementedGoal = HabitData(goal: habit.goal, completedCount: completed, description: habit.description)
        
        //tries to find the goal index by comparing the goal names
        if let goalIndex = habitsViewModel.habitsList.firstIndex(where: { $0.goal == decrementedGoal.goal }) {
            
            print(goalIndex)
            
            //replaces the old goal with the new goal using the index found
            habitsViewModel.habitsList[goalIndex] = decrementedGoal
        }
    }
    
    func incrementCompleted() {
        completed += 1
        
        let incrementedGoal = HabitData(goal: habit.goal, completedCount: completed, description: habit.description)
        
        if let goalIndex = habitsViewModel.habitsList.firstIndex(where: { $0.goal == incrementedGoal.goal }) {
            
            print(goalIndex)
            habitsViewModel.habitsList[goalIndex] = incrementedGoal
        }
    }
}

#Preview {
    HabitDetailView(habitsViewModel: HabitsViewModel(), habit: HabitsViewModel.SampleHabits[0], completed: 0)
}
