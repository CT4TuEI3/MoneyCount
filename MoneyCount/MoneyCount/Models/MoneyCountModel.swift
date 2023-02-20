//
//  MoneyCountModel.swift
//  MoneyCount
//
//  Created by Алексей on 16.02.2023.
//

import Foundation

/// Модель MoneyCount
struct MoneyCountModel: Codable {
    /// Наименоввание MoneyCount
    let title: String
    
    ///  Описание MoneyCount
    let description: String
    
    /// Имена участвующие в MoneyCount
    var names: [NameBalanceModel]
    
    /// Выбранная валюта
    let currency: String
    
    /// Модель расходов
    var expence: [ExpenceModel]
}

/// Модель расходов
struct ExpenceModel: Codable {
    
    /// Название расхода
    let title: String
    
    /// Сумма расхода
    let amount: Double
    
    /// Дата расхода
    let date: String
    
    /// Имена в расходе
    let names: [NameBalanceModel]
}

/// Струтура имён и балансов
struct NameBalanceModel: Codable {
    
    ///Имя пользователя
    let name: String
    
    /// Баланс пользователя
    var balance: Double
}
