//
//  File.swift
//  CurrenciesExchange
//
//  Created by Apple on 04/07/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit

//The task is to implement code for a supermarket scanner that scans items in one at a time and calculates the total price of your basket after you're done scanning.
//
//The items codes are individual letters of the alphabet (A, B, C, and so on). Our goods are priced individually. In addition, there are special deals on some combinations of products.
//
//For example, item ‘A’ might cost 50 pence individually, but we have a special offer: buy three ‘A’s and they'll cost you £1.30. In fact this week's pri

//Product prices
//
//Prices per 1 item:
//Item     Price
//A     50
//B     30
//C     20
//D     15

//Special deals
//
//Prices per a complete set of items:
//Items     Price
//A + A + A     130
//B + B     45

protocol Checkout {
    func scan(char: String)
    func total() -> Int
}

class Basket: Checkout {
    var arrayItem: [String: Int] = ["A": 50, "B": 30, "C": 20, "D": 15]
    var arrayItemBuy: [String] = []
    var itemPrice: Int = 0
    var totalPrice: Int = 0
    
    func scan(char: String) {
        itemPrice = arrayItem[char]!
        arrayItemBuy.append(char)
        totalPrice = totalPrice + itemPrice
        self.special()
    }
    
    func total() -> Int {
        return totalPrice
    }
    
    func special() {
        var countOfProductA = 0
        var countOfProductB = 0
        
        for obj in arrayItemBuy {
            if obj == "A" {
                countOfProductA += countOfProductA
            }else if obj == "B" {
                countOfProductB += countOfProductB
            }
        }
        
        if countOfProductA >= 3 {
            totalPrice = totalPrice - (20 * (countOfProductA/3))
        }
        
        if countOfProductB >= 2 {
            totalPrice = totalPrice - (15 * (countOfProductB/2))
        }
    }
}

class Sell {
    
    var obj: Basket = Basket()
    
    func scanItem(product: String) {
        obj.scan(char: product)
    }
    
    func totalPrice() -> Int {
        return obj.total()
    }
}

