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
    /// - Returns: Полученная модель
    func getData(completion: @escaping (Result<MoneyCountModel, Error>) -> Void) -> MoneyCountModel?
}


final class FireBaseService: FireBaseServiceProtocol {
    
    // MARK: - Private Property
    
    private let dataBase = Firestore.firestore()
    
    
    // MARK: - Methods
    
    func saveData(moneyCount: MoneyCountModel, _ completion: @escaping (Error?) -> Void) {
        dataBase.collection("Counts").document("MoneyCounts").setData(["title" : moneyCount.title,
                                                                 "description": moneyCount.description,
                                                                 "names": setNames(moneyCount: moneyCount),
                                                                 "currency": "rub",
                                                                 "expence": moneyCount.expence]) { error in
        completion(error)
        }
    }

    func getData(completion: @escaping (Result<MoneyCountModel, Error>) -> Void) -> MoneyCountModel? {
        var moneyCount: MoneyCountModel?
        let docRef = dataBase.collection("Counts").document("MoneyCounts")
        docRef.getDocument(as: MoneyCountModel.self) { result in
            completion(result)
        }
        return moneyCount
    }
    
    
    // MARK: - Private methods
    
    private func setNames(moneyCount: MoneyCountModel) -> [[String: Any]] {
        var result: [[String: Any]] = []
        moneyCount.names.forEach {
            result.append(["name": $0.name, "balance": $0.balance])
        }
        return result
    }
}

