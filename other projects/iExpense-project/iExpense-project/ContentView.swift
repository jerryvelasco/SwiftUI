//
//  ContentView.swift
//  iExpense-project
//
//  Created by jerry on 12/2/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showExpenseForm = false      //controls when to show the sheet
    @State private var filterBy = "All"             //controls what to filter by
    
    //controls the sort order
    @State private var sortOrder = [
        SortDescriptor(\ExpenseModel.name),
        SortDescriptor(\ExpenseModel.cost)
    ]
    
    var body: some View {
        NavigationStack {
            ExpenseView(filterBy: filterBy, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    
                    //triggers the sheet 
                    Button("Add", systemImage: "plus") {
                        showExpenseForm.toggle()
                    }
                    
                    //provides sort and filter options
                    Menu("Options", systemImage: "line.3.horizontal.decrease.circle") {
                        Menu("Sort By") {
                            
                            //using the tag modifier we attach an array of sort descriptors to each of the options that the picker creates allowing for the expenses to be re-arranged
                            Picker("sort", selection: $sortOrder) {
                                Text("Name")
                                    .tag([
                                        SortDescriptor(\ExpenseModel.name),
                                        SortDescriptor(\ExpenseModel.cost)
                                    ])
                                
                                Text("Cost")
                                    .tag([
                                        SortDescriptor(\ExpenseModel.cost),
                                        SortDescriptor(\ExpenseModel.name)
                                    ])
                            }
                        }
                        
                        Menu("Filter By") {
                            
                            //buttons change the filter value
                            Button("Show All") {
                                filterBy = "All"
                            }
                            Button("Buisness") {
                                filterBy = "Business"
                            }
                            Button("Personal") {
                                filterBy = "Personal"
                            }
                        }
                    }
                }
                .sheet(isPresented: $showExpenseForm, content: {
                    NewExpenseView()
                })
        }
    }
}

#Preview {
    ContentView()
}
