//
//  PipCalculatorTest.swift
//  TradelyticsTests
//
//  Created by Bhris on 11/26/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import XCTest
@testable import Tradelytics

class PipCalculatorTest: XCTestCase {
    
    let pipCalculator = PipCalculator()
    
    override class func setUp() {}
    
    override func tearDown() {}
    
    func test_givenUSDJPY_whenInBuyExecution_calculate10PipPositive() {
        let entryPrice = 109.132
        let exitPrice = 109.232
        let netPips = pipCalculator.calculatePips(for: .usdjpy, tradeType: .buyExec, entry: entryPrice, exit: exitPrice)
        XCTAssertEqual(netPips, 10.0)
    }
    
    func test_givenAUDJPY_whenInSellExecution_calculate10_4_PipPositive() {
        let entryPrice = 74.048
        let exitPrice = 73.944
        let netPips = pipCalculator.calculatePips(for: .usdjpy, tradeType: .sellExec, entry: entryPrice, exit: exitPrice)
        XCTAssertEqual(netPips, 10.4)
    }
    
    func test_givenXAUUSD_whenInBuyLimit_calculate22_1_PipNegative() {
        let entryPrice = 1462.21
        let exitPrice = 1460.00
        let netPips = pipCalculator.calculatePips(for: .xauusd, tradeType: .buyLimit, entry: entryPrice, exit: exitPrice)
        XCTAssertEqual(netPips, -22.1)
    }
    
    func test_givenEURAUD_whenInSellStop_calculate35_3_PipPositive() {
        let entryPrice = 1.62322
        let exitPrice = 1.61969
        let netPips = pipCalculator.calculatePips(for: .euraud, tradeType: .sellStop, entry: entryPrice, exit: exitPrice)
        XCTAssertEqual(netPips, 35.3)
    }
    
    func test_givenUSOIL_whenInSellLimit_calculate200PipPositive() {
        let entryPrice = 60.3
        let exitPrice = 40.3
        let netPips = pipCalculator.calculatePips(for: .usOil, tradeType: .sellLimit, entry: entryPrice, exit: exitPrice)
        XCTAssertEqual(netPips, 200)
    }
    
    func test_givenBTCUSD_wheInBuyStop_calculate25_3PipNegative() {
        let entryPrice = 7163.3
        let exitPrice = 7138.0
        let netPips = pipCalculator.calculatePips(for: .btcusd, tradeType: .buyStop, entry: entryPrice, exit: exitPrice)
        XCTAssertEqual(netPips, -25.3)
    }
}
