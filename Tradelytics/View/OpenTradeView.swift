//
//  OpenTradeView.swift
//  Tradelytics
//
//  Created by Bhris on 11/18/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI

struct OpenTradeView: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        return formatter
    }()
    let numberFormatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           formatter.maximumFractionDigits = 5
           return formatter
       }()
    let trade: Trade
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 15) {
                Text(trade.pair.rawValue)
                    .multilineTextAlignment(.leading)
                Text(trade.entryPrice.description)
                Text(dateFormatter.string(from: trade.entryDate))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
