//
//  TradeStore.swift
//  Tradelytics
//
//  Created by Bhris on 11/16/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI
import Combine

class TradeStore : ObservableObject {

    @Published var openTrades: [Trade] = []
    @Published var completedTrades: [Trade] = []
    private let service: TradeService

    init(service: TradeService) {
        self.service = service
    }

    func fetchTrades() {
        service.fetchTrades { openTrades, completedTrades in
            self.openTrades = openTrades
            self.completedTrades = completedTrades
            self.openTrades.sort { $0.entryDate > $1.entryDate }
            self.completedTrades.sort { $0.entryDate > $1.entryDate }
        }
    }
    
    func open(trades: [Trade]) {
        for trade in trades {
            service.insert(trade: trade)
        }
        fetchTrades()
    }
    
    func close(trade: Trade) {
        trade.isCompleted = true
        service.update(trade: trade) {
            self.fetchTrades()
        }
    }
    
    func cancel(trade: Trade) {
        service.delete(trade: trade) {
            self.fetchTrades()
        }
    }
}
