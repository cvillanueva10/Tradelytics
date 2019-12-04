//
//  CurrencyPair.swift
//  Tradelytics
//
//  Created by Bhris on 11/15/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import Foundation

enum CurrencyPair: String {
    case none = "Select Currency Pair"
    case audcad = "AUDCAD"
    case audchf = "AUDCHF"
    case audjpy = "AUDJPY"
    case audnzd = "AUDNZD"
    case audusd = "AUDUSD"
    case btcusd = "BTCUSD"
    case cadchf = "CADCHF"
    case cadjpy = "CADJPY"
    case chfjpy = "CHFJPY"
    case euraud = "EURAUD"
    case eurcad = "EURCAD"
    case eurchf = "EURCHF"
    case eurgbp = "EURGBP"
    case eurjpy = "EURJPY"
    case eurnzd = "EURNZD"
    case eurusd = "EURUSD"
    case gbpaud = "GBPAUD"
    case gbpcad = "GBPCAD"
    case gbpchf = "GBPCHF"
    case gbpjpy = "GBPJPY"
    case gbpnzd = "GBPNZD"
    case gbpusd = "GBPUSD"
    case nzdcad = "NZDCAD"
    case nzdchf = "NZDCHF"
    case nzdjpy = "NZDJPY"
    case nzdusd = "NZDUSD"
    case usdcad = "USDCAD"
    case usdchf = "USDCHF"
    case usdjpy = "USDJPY"
    case xagusd = "XAGUSD"
    case xauusd = "XAUUSD"
    case usOil = "USOIL"
}

extension CurrencyPair: CaseIterable {
    
}

extension CurrencyPair: Identifiable {
    var id: String { rawValue }
}
