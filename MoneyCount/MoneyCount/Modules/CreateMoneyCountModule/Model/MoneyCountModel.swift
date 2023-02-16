//
//  MoneyCountModel.swift
//  MoneyCount
//
//  Created by Алексей on 16.02.2023.
//

import Foundation

/// Модель MoneyCount
struct MoneyCountModel: Decodable {
    /// Наименоввание MoneyCount
    let title: String
    
    ///  Описание MoneyCount
    let description: String
    
    /// Имена участвующие в MoneyCount
    let names: [NameBalanceModel]
    
    /// Выбранная валюта
    let currency: String
    
    /// Модель расходов
    let expence: [ExpenceModel]
}

/// Модель расходов
struct ExpenceModel: Decodable {
    
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
struct NameBalanceModel: Decodable {
    
    ///Имя пользователя
    let name: String
    
    /// Баланс пользователя
    let balance: Double
}
