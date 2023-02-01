//
//  AddExpenseEntity.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

enum AddExpenseSectionType: CaseIterable {
    /// Наименование расхода
    case title
    
    ///  Сумма расхода
    case amount
    
    /// Дата расхода
    case date
    
    /// Имя платившего
    case name
}
