//
//  ContentView.swift
//  HabitTracking
//
//  Created by jerry on 11/6/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var habitsViewModel = HabitsViewModel()
    
    @State private var showDeleteAlert = false
    @State private var showForm = false
    @State private var indexSetToDelete: IndexSet?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitsViewModel.habitsList, id: \.id) { goal in
                    
                    NavigationLink(value: goal) {
                        
                        ListRow(goal: goal.goal,
                                completed: goal.completedCount,
                                description: goal.description)
                    }
                }
                .onDelete(perform: { indexSet in
                    
                    showDeleteAlert = true
                    
                    //finds the index of goal that user want to delete
                    self.indexSetToDelete = indexSet
                })
            }
            .navigationDestination(for: HabitData.self, destination: { habit in
                
                HabitDetailView(habitsViewModel: habitsViewModel,
                                habit: habit,
                                completed: habit.completedCount)
                
            })
            .navigationTitle("Habit Tracking")
            .toolbar {
                ToolbarItemGroup {
                    Button("add", systemImage: "plus") {
                        
                        showForm = true
                    }
                    
                    EditButton()
                }
            }
            .sheet(isPresented: $showForm, content: {
                NewHabitFormView(habitsViewModel: habitsViewModel)
            })
            
            //shows alert when the delete button is clicked
            .alert("Delete Activity", isPresented: $showDeleteAlert) {
                
                Button("Cancel", role: .cancel) {}
                
                Button("Delete", role: .destructive) {
                    self.removeHabits(index: indexSetToDelete!)
                }
                
            } message: {
                Text("Confirm deleting this goal: ")
            }
        }
        .preferredColorScheme(.light)
    }
    
    func removeHabits(index: IndexSet) {
        habitsViewModel.habitsList.remove(atOffsets: index)
    }
}

#Preview {
    ContentView()
}

/*
sample row goal view 
*/
struct ListRow: View {
    
    let goal: String
    let completed: Int
    let description: String
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(goal)
                .font(.title).fontWeight(.semibold)
            
            HStack {
                Image(systemName: "flag.checkered.2.crossed")
                
                Text("\(completed)x streak")
            }
            .font(.headline)
            
            Text(description)
        }
    }
}
