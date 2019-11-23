//
//  TradeType.swift
//  Tradelytics
//
//  Created by Bhris on 11/19/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import Foundation

enum TradeType: String {
    case none = "Select Trade Type"
    case buyExec = "Buy Execution"
    case sellExec = "Sell Execution"
    case buyLimit = "Buy Limit"
    case sellLimit = "Sell Limit"
    case buyStop = "Buy Stop"
    case sellStop = "Sell Stop"
}

extension TradeType: CaseIterable {
    
}

extension TradeType: Identifiable {
    var id: String { rawValue }
}
