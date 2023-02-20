//
//  FireBaseService.swift
//  MoneyCount
//
//  Created by Алексей on 16.02.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FireBaseServiceProtocol {
    /// Отправляет данные в базу данных
    /// - Parameter moneyCount: Сохраняемая модель
    /// - Parameter completion: Ошибка
    func saveData(moneyCount: MoneyCountModel, _ completion: @escaping (Error?) -> Void)
    
    /// Получение данных из базы данных
    func getData(completion: @escaping (Result<MoneyCountModel, Error>) -> Void)
}


final class FireBaseService: FireBaseServiceProtocol {
    
    // MARK: - Private Property
    
    private let dataBase = Firestore.firestore()
    
    
    // MARK: - Methods
    
    func saveData(moneyCount: MoneyCountModel, _ completion: @escaping (Error?) -> Void) {
        try? dataBase.collection("Counts").document("MoneyCounts").setData(from: moneyCount, completion: { error in
            completion(error)
        })
    }
    
    func getData(completion: @escaping (Result<MoneyCountModel, Error>) -> Void) {
        let docRef = dataBase.collection("Counts").document("MoneyCounts")
        docRef.getDocument(as: MoneyCountModel.self) { result in
            completion(result)
        }
    }
}

