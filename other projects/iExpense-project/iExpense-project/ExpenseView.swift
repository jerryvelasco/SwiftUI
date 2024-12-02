//
//  ExpenseView.swift
//  iExpense-project
//
//  Created by jerry on 12/2/24.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseModel]              //loads the models saved to the model context
    
    var body: some View {
        List {
            ForEach(expenses) { expense in          //loops through the expenses saved
                Section(expense.type) {
                    HStack {
                        Text(expense.name)
                        
                        Spacer()
                        
                        Text(expense.cost, format: .currency(code: "USD"))
                            .foregroundStyle(formatPrices(expense.cost))
                    }
                }
            }
            //swipe to delete capability
            .onDelete(perform: { indexSet in
                deleteExpenses(offset: indexSet)
            })
        }
    }
    
    
    //looks for the index of the model selected and deletes them from the model context
    func deleteExpenses(offset: IndexSet) {
        for index in offset {
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }
    
    
    //formats the cost text color based on their value
    private func formatPrices(_ cost: Decimal) -> Color {
        if cost < 10 {
            return Color.blue
        } else if cost < 100 {
            return Color.green
        } else {
            return Color.red
        }
    }
    
    //provides sort and filter required before the expenses are displayed
    //values are passed in from the content view
    init(filterBy: String, sortOrder: [SortDescriptor<ExpenseModel>]) {
        
        //underscore grants access to the swiftdata query
        _expenses = Query(filter: #Predicate<ExpenseModel> { expense in
            
            //will display expenses based on the expense type passed in
            if filterBy == "Business" {
                return expense.type == "Business"
            }
            else if filterBy == "Personal}" {
                return expense.type == "Personal"
            }
            else {
                return expense.type == "Business" || expense.type == "Personal"
            }
        }, sort: sortOrder)
    }
}

#Preview {
    
    //dummy values for the preview 
    ExpenseView(filterBy: "All", sortOrder: [SortDescriptor(\ExpenseModel.name)])
        .modelContainer(for: ExpenseModel.self)
}
