//
//  CompleteTradeView.swift
//  Tradelytics
//
//  Created by Bhris on 11/19/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI
import Combine

struct CloseTradeView: View {
    
    let trade: Trade
    
    var body: some View {
        Text(trade.pair.rawValue)
    }
}
