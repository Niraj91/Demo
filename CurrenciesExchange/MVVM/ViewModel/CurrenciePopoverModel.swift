//
//  CurrenciePopoverModel.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit
import ObjectMapper

class CurrenciePopoverModel: NSObject {
    
    // Model object
    private var objCurrencies: Currencies?
    
    // MARK: - Closure
    var reloadTable: ()->() = { }
    var didSelectRow: (_ quote:String, _ currencie:String)->() = {quote,currencie in }
    
    /// Row Count
    func getRowCount() -> Int {
        if let obj = objCurrencies {
            return (obj.currenciesList?.keys.count)!
        }
        return 0
    }
    
    /// Get row data
    func getDataForRow(index:Int) -> String {
        return objCurrencies!.currenciesList![self.getKeyArray()[index]]!
    }
    
    //Get the key list from Currencies dis
    private func getKeyArray() -> Array<String> {
        return Array((objCurrencies!.currenciesList?.keys)!)
    }
    
    /// Webservice Currencie List
    func getCurrencieList() -> Void {
        BaseReqeustClass.GETRequset(apiName: apiName.none, url: apiURL.currencieList, showLoader: true, responseModel: Mapper<Currencies>()) { (reponce) in
            self.objCurrencies = reponce as? Currencies
            self.reloadTable()
        }
    }
    
    /// Webservice Currencie Price
    func getSelectCurrenciesPrice(index:Int) -> Void {
        BaseReqeustClass.GETRequset(apiName: apiName.none, url: apiURL.apilayerURL, showLoader: true, responseModel: Mapper<Currencies>()) { (reponce) in
            var objCurrencies: Currencies = (reponce as? Currencies)!
            
            self.didSelectRow("\(objCurrencies.currenciesQuotes!["USD\(self.getKeyArray()[index])"]!)", self.getKeyArray()[index])
        }
    }
}
