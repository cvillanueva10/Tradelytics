//
//  TradeService.swift
//  Tradelytics
//
//  Created by Bhris on 11/22/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import Combine
import Foundation
import FirebaseFirestore
import SwiftUI

class TradeService {
    
    let db = Firestore.firestore()
    let session: SessionStore
    
    init(session: SessionStore) {
        self.session = session
    }
    
    func insert(trade: Trade) {
        guard let userId = session.getUserId() else { return }
        db.collection("users").document(userId).collection("trades").document(trade.id).setData([
            "entry_date" : Timestamp(date: trade.entryDate),
            "entry_price" : trade.entryPrice,
            "pair" : trade.pair.rawValue,
            "exit_date" : NSNull(),
            "exit_price" : NSNull(),
            "type" : trade.type.rawValue,
            "method": trade.method,
            "is_completed": trade.isCompleted
        ])
    }
    
    func update(trade: Trade, completion: @escaping () -> ()) {
        guard let userId = session.getUserId() else { return }
        let tradeReference = db.collection("users").document(userId).collection("trades").document(trade.id)
        db.runTransaction({ (transaction, error) -> Any? in
            do {
                try _ = transaction.getDocument(tradeReference)
            } catch let fetchError as NSError {
                error?.pointee = fetchError
                return nil
            }
            guard let exitDate = trade.exitDate else { return nil }
            transaction.updateData(["exit_price": trade.exitPrice as Any,
                                    "exit_date" : Timestamp(date: exitDate),
                                    "is_completed": true], forDocument: tradeReference)
            return nil
        }) { response, error in
            if let error = error {
                print(error)
            }
            completion()
        }
    }
    
    func fetchTrades(completion: @escaping (([Trade], [Trade]) -> ())) {
        guard let userId = session.getUserId() else { return }
        var openTrades: [Trade] = []
        var completedTrades: [Trade] = []
        db.collection("users").document(userId).collection("trades").getDocuments { snapshot, error in
            if let error = error {
                print(error)
            }
            guard let documentChanges = snapshot?.documentChanges else {
                print("ERROR WITH SNAPSHOT")
                return
            }
            for change in documentChanges {
                let data = change.document.data()
                guard let isCompleted = data["is_completed"] as? Bool else { continue }
                if isCompleted {
                    completedTrades.append(.init(id: change.document.documentID, data: change.document.data()))
                } else {
                    openTrades.append(.init(id: change.document.documentID, data: change.document.data()))
                }
            }
            completion(openTrades, completedTrades)
        }
    }
}
