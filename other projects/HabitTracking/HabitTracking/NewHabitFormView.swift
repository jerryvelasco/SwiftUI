//
//  NewHabitFormView.swift
//  HabitTracking
//
//  Created by jerry on 11/6/24.
//

import SwiftUI

struct NewHabitFormView: View {
    
    @ObservedObject var habitsViewModel: HabitsViewModel
    
    @State private var goal = ""
    @State private var description = ""
    @State private var completed = 0
    
    @Environment(\.dismiss) var dismiss
    
    //checks if the text fields are empty
    private var goalsEmpty: Bool {
        if goal == "" {
            return true
        }
        return false
    }
    
    //checks if the text fields are empty
    private var descriptionsEmpty: Bool {
        if description == "" {
            return true
        }
        return false
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("New Habit")
                    .font(.largeTitle).bold()
                
                TextFieldView(title: "Goal", imageName: "star.fill", frameHeight: 20.0, goalValue: $goal)
                
                TextFieldView(goalValue: $description)
                
                HStack(spacing: 50) {
                    Button {
                        dismiss()
                        
                    } label: {
                        CapsuleButton(title: "Cancel")
                        
                    }
                    
                    Button {
                        saveHabit()
                        dismiss()
                        
                    } label: {
                        //background color is gray if both text fields are empty
                        CapsuleButton(title: "Create",
                                      backgroundColor: !goalsEmpty && !descriptionsEmpty ? Color.blue : Color.gray)
                    }
                    //disables button if either text fields are empty
                    .disabled(goalsEmpty || descriptionsEmpty)
                }
            }
            .FormBackgroundStyle()
        }
        .padding()
        Spacer()
    }
    
    //controls saving new habits created
    func saveHabit() {
        
        //creates a new instance
        let newHabit = HabitData(goal: goal,
                                 completedCount: completed,
                                 description: description)
        
        //and then adds it to the list
        habitsViewModel.habitsList.append(newHabit)
    }
}

#Preview {
    NewHabitFormView(habitsViewModel: HabitsViewModel())
}
