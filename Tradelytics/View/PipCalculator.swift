//
//  PipCalculator.swift
//  Tradelytics
//
//  Created by Bhris on 11/26/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import Foundation

final class PipCalculator {
    
    init() {}
    
    func calculatePips(for pair: CurrencyPair, tradeType: TradeType, entry: Double, exit: Double) -> Double {
        let rawDifference = exit - entry
        let pipDifference = (rawDifference * getMultiplyFactor(for: pair)).rounded(toPlaces: 1)
        return isSell(for: tradeType) ? pipDifference * -1 : pipDifference
    }
    
    private func getMultiplyFactor(for pair: CurrencyPair) -> Double {
        if pair.isJpyPair {
            return 100
        } else if pair.isGold || pair.isOil {
            return 10
        } else if pair.isCrypto {
            return 1
        } else {
            return 10000
        }
        
    }
    
    private func isSell(for type: TradeType) -> Bool {
        return type == .sellLimit || type == .sellExec || type == .sellStop
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension CurrencyPair {
    var isJpyPair: Bool {
        return self == .usdjpy || self == .eurjpy || self == .nzdjpy || self == .audjpy || self == .cadjpy || self == .gbpjpy || self == .chfjpy
    }
    
    var isGold: Bool {
        return self == .xauusd
    }
    
    var isOil: Bool {
        return self == .usOil
    }
    
    var isCrypto: Bool {
        return self == .btcusd
    }
}
