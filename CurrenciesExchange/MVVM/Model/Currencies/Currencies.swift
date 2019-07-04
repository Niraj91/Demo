//
//  Experiences.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import Foundation
import ObjectMapper

struct Currencies: Mappable {
    
    var success: Bool?
    var terms: String?
    var privacy: String?
    var currenciesList: [String:String]?
    var currenciesQuotes: [String:Any]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        terms <- map["terms"]
        privacy <- map["privacy"]
        currenciesList <- map["currencies"]
        currenciesQuotes <- map["quotes"]
    }
}
