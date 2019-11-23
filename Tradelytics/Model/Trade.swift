//
//  Trade.swift
//  Tradelytics
//
//  Created by Bhris on 11/15/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import Foundation
import Firebase

class Trade: Identifiable {
    let id: String
    var entryDate: Date
    var entryPrice: Decimal
    var exitDate: Date? = nil
    var exitPrice: Decimal? = nil
    var isCompleted = false
    let pair: CurrencyPair
    let type: TradeType
    let method: String
    
    private var numberFormatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           formatter.maximumFractionDigits = 5
           return formatter
       }()
    
    init(id: String, entryDate: Date, entryPrice: Decimal, pair: CurrencyPair, type: TradeType, method: String) {
        self.id = id
        self.entryDate = entryDate
        self.entryPrice = entryPrice
        self.pair = pair
        self.type = type
        self.method = method
    }

    init(id: String, data: [String: Any]) {
        self.id = id
        self.entryDate = (data["entry_date"] as! Timestamp).dateValue()
        self.entryPrice = (data["entry_price"] as! NSNumber).decimalValue
        self.pair = CurrencyPair(rawValue: data["pair"] as! String)!
        if let exitDate = data["exit_date"] as? Timestamp {
            self.exitDate = exitDate.dateValue()
        }
        if let exitPrice = data["exit_price"] as? Decimal {
            self.exitPrice = exitPrice
        }
        self.type = TradeType(rawValue: data["type"] as! String)!
        self.method = data["method"] as! String
    }
    
    func closeTrade(with price: Decimal) {
        exitPrice = price
        exitDate = Date()
    }
}
