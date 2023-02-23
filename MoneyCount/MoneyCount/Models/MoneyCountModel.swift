//
//  MoneyCountModel.swift
//  MoneyCount
//
//  Created by Алексей on 16.02.2023.
//

import Foundation

/// The moneyCount model storing the data of users, their balance and expenses
struct MoneyCountModel: Codable {
    /// Title MoneyCount
    let title: String
    
    ///  Description MoneyCount
    let description: String
    
    /// Names of all MoneyCount members
    var names: [NameBalanceModel]
    
    /// Base currency MoneyCount
    let currency: String
    
    /// MoneyCount expenditure model
    var expence: [ExpenceModel]
}

/// MoneyCount user spending model
struct ExpenceModel: Codable {
    
    /// Name of expense
    let title: String
    
    /// Amount of expense
    let amount: Double
    
    /// Date of expense
    let date: String
    
    /// Users participating in the expense
    let names: [NameBalanceModel]
}

/// Structure of users and their balances
struct NameBalanceModel: Codable {
    
    /// Username
    let name: String
    
    /// User balance
    var balance: Double
}
