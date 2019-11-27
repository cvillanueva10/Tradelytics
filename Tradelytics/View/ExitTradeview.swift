//
//  CompleteTradeView.swift
//  Tradelytics
//
//  Created by Bhris on 11/19/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI
import Combine

struct ExitTradeView: View {

    @Environment(\.presentationMode) var mode
    @State var exitPrice: Decimal? = nil
    let trade: Trade
    var didCloseTrade: (Trade) -> ()
    
    private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 5
        return formatter
    }()
    
    init(trade: Trade, didCloseTrade: @escaping (Trade) -> ()) {
        self.trade = trade
        self.didCloseTrade = didCloseTrade
    }
    
    var body: some View {
        Form {
            Text(trade.pair.rawValue)
            Text("Entry Price: \(trade.entryPrice.description)")
            HStack(spacing: 16) {
                Text("Exit Price")
                DecimalField(label: "Enter price", value: $exitPrice, formatter: numberFormatter)
            }
            Button(action: {
                guard let exitPrice = self.exitPrice else { return }
                self.trade.closeTrade(with: exitPrice)
                self.didCloseTrade(self.trade)
                self.mode.wrappedValue.dismiss()
            }) {
                Text("Close Trade")
            }
        }
    }
}
