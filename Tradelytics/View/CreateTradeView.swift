//
//  AddTradeView.swift
//  Tradelytics
//
//  Created by Bhris on 11/16/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI
import Combine

struct CreateTradeView: View {
    
    @Binding var isPresented: Bool
    @State var isPresentingSelectCurrencyModal: Bool = false
    @State var isPresentingSelectTypeModal: Bool = false
    @State var selectedCurrencyPair: CurrencyPair = .none
    @State var selectedTradeType: TradeType = .none
    @State var firstEntryPrice: Decimal? = nil
    @State var secondEntryPrice: Decimal? = nil
    @State var method: String = ""
    @State var showSecondEntryField: Bool = false
    var didCreateTrade: ([Trade]) -> ()
    
   private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 5
        return formatter
    }()
    
    private var isInvalidTrade: Bool {
        return selectedCurrencyPair == .none || firstEntryPrice == nil || selectedTradeType == .none || (showSecondEntryField && secondEntryPrice == nil)
    }

    init(isPresented: Binding<Bool>, didCreateTrade: @escaping ([Trade]) -> ()) {
        self._isPresented = isPresented
        self.didCreateTrade = didCreateTrade
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Button(action: selectCurrency, label: {
                        Text(selectedCurrencyPair.rawValue)
                    }).sheet(isPresented: $isPresentingSelectCurrencyModal) {
                        SelectCurrencyView(isPresented: self.$isPresentingSelectCurrencyModal, didSelectCurrency: { currency in
                            self.selectedCurrencyPair = currency
                        })
                    }
                    
                    Button(action: selectType, label: {
                        Text(selectedTradeType.rawValue)
                    }).sheet(isPresented: $isPresentingSelectTypeModal) {
                        SelectTypeView(isPresented: self.$isPresentingSelectTypeModal) { type in
                            self.selectedTradeType = type
                        }
                    }
                    Section {
                        HStack(spacing: 16) {
                            Text("Entry Price")
                            DecimalField(label: "Enter price", value: $firstEntryPrice, formatter: numberFormatter).keyboardType(.decimalPad)
                        }
                        if showSecondEntryField {
                            HStack(spacing: 16) {
                                Text("Entry Price 2")
                                DecimalField(label: "Enter price", value: $secondEntryPrice, formatter: numberFormatter).keyboardType(.decimalPad)
                            }
                        }
                        Button(action: {
                            self.showSecondEntryField.toggle()
                        }) {
                            Text(showSecondEntryField ? "Remove Twin Trade" : "Add Twin Trade")
                        }
                    }
                    HStack(spacing: 16) {
                        Text("Method")
                        TextField("Enter method", text: $method)
                    }
                    Section {
                        Button(action: {
                            self.didCreateTrade(self.newTrades())
                            self.isPresented = false
                        }) {
                            Text("Create Trade").frame(alignment: .center)
                            }.disabled(isInvalidTrade)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        
                    }
                }.navigationBarTitle("Create Trade Entry")
            }
            
        }
    }
    
    private func newTrades() -> [Trade] {
        var trades: [Trade] = []
        for price in [firstEntryPrice, secondEntryPrice] {
            guard let price = price else { continue }
            trades.append(.init(id: UUID().uuidString,
                                entryDate: Date(),
                                entryPrice: price,
                                pair: selectedCurrencyPair,
                                type: selectedTradeType,
                                method: method))
        }
        return trades
    }

    
    private func selectType() {
        self.isPresentingSelectTypeModal.toggle()
    }
    
    private func selectCurrency() {
        self.isPresentingSelectCurrencyModal.toggle()
    }
}

struct SelectCurrencyView: View {
    
    @Binding var isPresented: Bool
    var didSelectCurrency: (CurrencyPair) -> ()
    
    var body: some View {
        List {
            ForEach(CurrencyPair.allCases, id: \.rawValue) { pair in
                    Button(action: {
                        self.didSelectCurrency(pair)
                        self.isPresented = false
                    }) {
                        Text(pair.rawValue)
                    }
                
            }
        }
    }
}

struct SelectTypeView: View {
    
    @Binding var isPresented: Bool
    var didSelectType: (TradeType) -> ()
    
    var body: some View {
        List {
            ForEach(TradeType.allCases, id: \.rawValue) { type in
                Button(action: {
                    self.didSelectType(type)
                    self.isPresented = false
                }, label: {
                    Text(type.rawValue)
                })
            }
        }
    }
}

struct DecimalField : View {
    let label: String
    @Binding var value: Decimal?
    let formatter: NumberFormatter
    @State var displayedText: String? = nil
    @State var lastFormattedValue: Decimal? = nil
    
    var body: some View {
        let b = Binding<String>(
            get: { return self.displayedText ?? "" },
            set: { newValue in
                self.displayedText = newValue
                self.value = self.formatter.number(from: newValue)?.decimalValue
        })
        
        return TextField(label, text: b, onEditingChanged: { inFocus in
            if !inFocus {
                self.lastFormattedValue = self.formatter.number(from: b.wrappedValue)?.decimalValue
                if self.lastFormattedValue != nil {
                    DispatchQueue.main.async {
                        b.wrappedValue = self.formatter.string(for: self.lastFormattedValue!) ?? ""
                    }
                }
            }
        })
            .keyboardType(.decimalPad)
    }
}
