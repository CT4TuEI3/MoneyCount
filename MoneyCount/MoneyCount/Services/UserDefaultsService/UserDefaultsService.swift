//
//  UserDefaultsService.swift
//  MoneyCount
//
//  Created by Алексей on 19.02.2023.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func save<Stored>(data: Stored, forKey: UserDefaultsKeys)
    func getBool(forKey: UserDefaultsKeys) -> Bool
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    private let userDefautls = UserDefaults()
    
    func save<Stored>(data: Stored, forKey: UserDefaultsKeys) {
        userDefautls.set(data, forKey: forKey.rawValue)
    }
    
    func getBool(forKey: UserDefaultsKeys) -> Bool {
        userDefautls.bool(forKey: forKey.rawValue)
    }
}
