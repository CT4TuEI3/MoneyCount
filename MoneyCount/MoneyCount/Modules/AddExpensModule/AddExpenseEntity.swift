//
//  AddExpenseEntity.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

enum AddExpenseSectionType: Int, CaseIterable {
    /// Name of expense
    case title
    
    ///  Amount of expense
    case amount
    
    /// Date of expense
    case date
    
    /// Name paid expense
    case paidBy
    
    /// Name of payer
    case name
}

struct UsersInExpenses {
    /// Name of expense
    let name: String
    
    /// Balance user
    var balance: Double
    
    /// Selected status user
    var state: Bool
}
