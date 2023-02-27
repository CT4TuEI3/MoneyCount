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
    /// Sending data to a database
    /// - Parameter moneyCount: Saving model
    /// - Parameter completion: Error
    func saveData(moneyCount: MoneyCountModel, docTitle: String, _ completion: @escaping (Error) -> Void)
    
    /// Retrieve data from the database
    func getData(docTitle: String, completion: @escaping (Result<MoneyCountModel, Error>) -> Void)
    
    /// Get all moneyCounts from the ddatabase
    /// - Parameter completion: the resulting model
    func getAllDocs(completion: @escaping ([MoneyCountModel]?, Error?) -> Void)
}



final class FireBaseService: FireBaseServiceProtocol {
    
    // MARK: - Private Property
    
    private let dataBase = Firestore.firestore()
    
    
    // MARK: - Methods
    
    func saveData(moneyCount: MoneyCountModel, docTitle: String, _ completion: @escaping (Error) -> Void) {
        try? dataBase.collection("Counts").document(docTitle).setData(from: moneyCount, completion: { error in
            guard let error = error else { return }
            completion(error)
        })
    }
    
    func getData(docTitle: String, completion: @escaping (Result<MoneyCountModel, Error>) -> Void) {
        let docRef = dataBase.collection("Counts").document(docTitle)
        docRef.getDocument(as: MoneyCountModel.self) { result in
            completion(result)
        }
    }
    
    func getAllDocs(completion: @escaping ([MoneyCountModel]?, Error?) -> Void) {
        var counts: [MoneyCountModel] = []
        dataBase.collection("Counts").getDocuments() { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                completion(nil, error)
                return
            }
            for document in snapshot.documents {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                    let moneyCount = try JSONDecoder().decode(MoneyCountModel.self, from: jsonData)
                    counts.append(moneyCount)
                } catch {
                    completion(counts, error)
                }
            }
            completion(counts, nil)
            
        }
    }
}

