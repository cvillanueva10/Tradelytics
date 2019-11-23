//
//  AddTradeView.swift
//  Tradelytics
//
//  Created by Bhris on 11/16/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI
import Combine

struct SelectCurrencyView: View {
    
    @Binding var isShown: Bool
    
    var body: some View {
        List {
            ForEach(CurrencyPair.allCases, id: \.rawValue) { pair in
                Text(pair.rawValue)
            }
        }
    }
    
}
