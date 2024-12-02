//
//  NewExpenseView.swift
//  iExpense-project
//
//  Created by jerry on 12/2/24.
//

import SwiftUI

struct NewExpenseView: View {
    
    @State var type = ExpenseModel.expenseTypes[0]          //provides a default value
    @State var cost = 0.0
    @State var name = "enter expense name"
    
    @Environment(\.modelContext) var modelContext           //grants access to the model context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Expense Type:", selection: $type) {
                        
                        ForEach(ExpenseModel.expenseTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Expense Cost", value: $cost, format: .currency(code: "USD"))
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Save") {
                            
                            //saves and dismisses the sheet
                            saveExpense()
                            dismiss()
                        }
                        Spacer()
                    }
                }
                .disabled(!formIsValid())       //disables saving if the validation is false
            }
            .navigationTitle($name)             //binding allows for the title to be edited
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()               //provides option to dismiss the sheeet
                    }
                }
            }
        }
    }
    
    
    //creates and then saves new model to the model context
    func saveExpense() {
        let newExpense = ExpenseModel(name: name, type: type, cost: Decimal(cost))
        
        modelContext.insert(newExpense)
    }
    
    
    //checks if the text fields are empty or have default values
    func formIsValid() -> Bool {
        if name == "enter expense name" || name.trimmingCharacters(in: .whitespaces).isEmpty || cost == 0.0 {
             return false
        }
        return true
    }
    
}

#Preview {
    NewExpenseView()
}
