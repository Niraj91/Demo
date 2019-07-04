//
//  Experience+CoreDataProperties.swift
//  CurrenciesExchange
//
//  Created by Niraj on 01/07/19.
//  Copyright © 2019 Niraj. All rights reserved.
//
//

import Foundation
import CoreData


extension Experience {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Experience> {
        return NSFetchRequest<Experience>(entityName: "Experience")
    }

    @NSManaged public var imgURL: URL?
    @NSManaged public var title: String?
    @NSManaged public var cost: Float
    @NSManaged public var currencyType: String?
    @NSManaged public var id: Int32
    @NSManaged public var currencyValue: Float

}
