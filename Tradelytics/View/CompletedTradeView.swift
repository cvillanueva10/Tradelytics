//
//  CompletedTradeView.swift
//  Tradelytics
//
//  Created by Bhris on 11/18/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI

struct CompletedTradeView: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    let trade: Trade
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 15) {
                Text(trade.pair.rawValue)
                    .multilineTextAlignment(.leading)
                Text("100 Pips")
                Text(dateFormatter.string(from: trade.entryDate))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

