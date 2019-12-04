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
    var netPips: Double = 0
    
    private let pipCalculator = PipCalculator()
    
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
        self.entryPrice = (data["entry_price"] as! NSNumber).decimalValue.rounded(toPlaces: 5)
        self.pair = CurrencyPair(rawValue: data["pair"] as! String)!
        if let netPips = data["net_pips"] as? NSNumber {
            self.netPips = netPips.doubleValue
        }
        if let exitDate = data["exit_date"] as? Timestamp {
            self.exitDate = exitDate.dateValue()
        }
        if let exitPrice = data["exit_price"] as? Decimal {
            self.exitPrice = exitPrice.rounded(toPlaces: 5)
        }
        self.type = TradeType(rawValue: data["type"] as! String)!
        self.method = data["method"] as! String
    }
    
    func closeTrade(with price: Decimal) {
        exitPrice = price
        exitDate = Date()
        let entryAsDouble = Double(truncating: entryPrice as NSNumber)
        let exitAsDouble = Double(truncating: price as NSNumber)
        netPips = pipCalculator.calculatePips(for: pair, tradeType: type, entry: entryAsDouble, exit: exitAsDouble)
    }
}

extension Decimal {
    func rounded(toPlaces places:Int) -> Decimal {
        let doubleVal = (self as NSNumber).doubleValue
        let divisor = pow(10.0, Double(places))
        let doubleResult = (doubleVal * divisor).rounded() / divisor
        return (doubleResult as NSNumber).decimalValue
    }
}
