//
//  ContentView.swift
//  Tradelytics
//
//  Created by Bhris on 11/15/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI

struct HistoryListView: View {
    
    @EnvironmentObject var store: TradeStore
    
    var body: some View {
        ForEach(store.completedTrades) { trade in
            CompletedTradeView(trade: trade)
        }
    }
}

struct TradeListView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var store: TradeStore
    @State private var addTradeViewIsShown: Bool = false
    
    var body: some View {
        Group {
            if(session.session == nil) {
                LoginView()
            } else {
                NavigationView {
                    VStack {
                        List {
                            Section(header: Text("Open Trades")) {
                                ForEach(store.openTrades) { trade in
                                    NavigationLink(destination: ExitTradeView(trade: trade, didCloseTrade: { trade in
                                        self.store.close(trade: trade)
                                    }, didCancelTrade: { trade in
                                        self.store.cancel(trade: trade)
                                    })) {
                                        OpenTradeView(trade: trade)
                                    }
                                }
                            }
                            Section {
                                Button("Add Trade") {
                                    self.addTradeViewIsShown.toggle()
                                }.sheet(isPresented: $addTradeViewIsShown) {
                                    CreateTradeView(isPresented: self.$addTradeViewIsShown) { trades in
                                        self.add(trades: trades)
                                    }
                                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            }
                            Section(header: Text("History")) {
                                HistoryListView()
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Trades")
                    }
                }
            }
        }.onAppear(perform: getUser)
    }
    
    func getUser () {
        session.listen(sessionFound: {
            self.store.fetchTrades()
        })
    }
    
    private func add(trades: [Trade]) {
        store.open(trades: trades)
    }
}


//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let trades = [Trade(id: "1", entryDate: Date(), entryPrice: 109.12, pair: .usdjpy, method: "Price Trap"),
//                      Trade(id: "2", entryDate: Date(), entryPrice: 1.02152, pair: .eurusd, method: "Price Trap"),
//                      Trade(id: "3", entryDate: Date(), entryPrice: 1.02319, pair: .euraud, method: "Head and Shoulders")]
//        TradeListView(trades: trades)
//    }
//}
