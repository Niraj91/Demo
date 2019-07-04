//
//  CheckOut.swift
//  CurrenciesExchangeTests
//
//  Created by Apple on 04/07/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import XCTest

protocol Checkout {
    func scan(char: String)
    func total() -> Int
}

class Basket: Checkout {
    var arrayItem: [String: Int] = ["A": 50, "B": 30, "C": 20, "D": 15]
    var arrayItemBuy: [String] = []
    var arrayoffer: [String:[String:Int]] = ["A": ["number":3, "Price": 130], "B": ["number":2, "Price": 45], "C": ["number":4, "Price": 70]]
    var dicItemCount: [String:Int] = [:]
    
    var itemPrice: Int = 0
    var totalPrice: Int = 0
    
    func scan(char: String) {
        itemPrice = arrayItem[char]!
        arrayItemBuy.append(char)
        totalPrice = totalPrice + itemPrice
    }
    
    func total() -> Int {
        self.special()
        return totalPrice
    }
    
    func special() {
        
        for obj in arrayItemBuy {
            let keys = Array(arrayoffer.keys)
            if keys.contains(obj){
                if let values = dicItemCount[obj] {
                    dicItemCount[obj] = values + 1
                }else{
                    dicItemCount[obj] = 1
                }
            }
        }
        
        let keys = Array(dicItemCount.keys)
        for keyName in keys {
            if let product = arrayoffer[keyName] {
                let itemPrice = arrayItem[keyName]
                let perItemPrice = itemPrice! * product["number"]!
                let finalPrice = perItemPrice - product["Price"]!
                
                if  dicItemCount[keyName]! >= product["number"]!{
                    totalPrice = totalPrice - (finalPrice * (dicItemCount[keyName]!/product["number"]!))
                }
            }
        }
    }
}

class CheckOut: XCTestCase {
    
    private func price(_ items: String) -> Int {
        let checkout: Checkout = Basket()
        items.forEach { checkout.scan(char: String($0)) }
        return checkout.total()
    }
        
    func test_total_isCorrect_for_empty_basket() {
            XCTAssertEqual(0, price(""))
    }
    
    func test_total_isCorrect_for_A() {
        XCTAssertEqual(50, price("A"))
    }
    
    func test_total_isCorrect_for_AB() {
        XCTAssertEqual(80, price("AB"))
    }
    
    func test_total_isCorrect_for_CDBA() {
        XCTAssertEqual(115, price("CDBA"))
    }
    
    func test_total_isCorrect_for_AA() {
        XCTAssertEqual(100, price("AA"))
    }
    
    func test_total_isCorrect_for_AAA() {
        XCTAssertEqual(130, price("AAA"))
    }
    
    func test_total_isCorrect_for_AAAA() {
        XCTAssertEqual(180, price("AAAA"))
    }
    
    func test_total_isCorrect_for_AAAAA() {
        XCTAssertEqual(230, price("AAAAA"))
    }
    
    func test_total_isCorrect_for_AAAAAA() {
        XCTAssertEqual(260, price("AAAAAA"))
    }
    
    func test_total_isCorrect_for_AAAB() {
        XCTAssertEqual(160, price("AAAB"))
    }
    func test_total_isCorrect_for_AAABB() {
        XCTAssertEqual(175, price("AAABB"))
    }
    
    func test_total_isCorrect_for_AAABBD() {
        XCTAssertEqual(190, price("AAABBD"))
    }
    
    func test_total_isCorrect_for_DABABA() {
        XCTAssertEqual(190, price("DABABA"))
    }
    
    func test_total_isCorrect_for_CCCC() {
        XCTAssertEqual(70, price("CCCC"))
    }
    
    func test_total_isCorrect_for_AAACCCC() {
        XCTAssertEqual(200, price("AAACCCC"))
    }
}
