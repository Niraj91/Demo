//
//  Experiences.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import Foundation
import ObjectMapper

struct Experiences: Mappable {
    
    var experiences: [ExperiencesList]?
    var currentCurrencieValues: Float = 1.0
    var currentCurrencieType: String = "USD"
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        experiences <- map["experiences"]
    }
}


struct ExperiencesList: Mappable {
    
	var id: Int?
	var title: String?
	var price_usd_cents: Int?
	var review_rating: Int?
	var image: String?
	var city: City?

	init?(map: Map) {
	}

	mutating func mapping(map: Map) {
		id <- map["id"]
		title <- map["title"]
		price_usd_cents <- map["price_usd_cents"]
		review_rating <- map["review_rating"]
		image <- map["image"]
		city <- map["city"]
	}
}

struct City: Mappable {
    
    var name: String?
    var country: Country?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        country <- map["country"]
    }
}

struct Country: Mappable {
    
    var name: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
