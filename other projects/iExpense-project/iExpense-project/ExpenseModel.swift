//
//  ExpenseModel.swift
//  iExpense-project
//
//  Created by jerry on 12/2/24.
//

import Foundation
import SwiftData

@Model
class ExpenseModel {
    
    var name: String
    var type: String
    var cost: Decimal
    
    static var expenseTypes = ["Business", "Personal"]
    
    init(name: String, type: String, cost: Decimal) {
        self.name = name
        self.type = type
        self.cost = cost
    }
}
