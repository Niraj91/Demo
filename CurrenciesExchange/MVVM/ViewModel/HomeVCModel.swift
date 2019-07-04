//
//  HomeVCModel.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//
import Foundation
import ObjectMapper
import CoreData

class HomeVCModel {
    
    // Model object
    private var objExperiences: Experiences?
    var objHome: HomeVC?
    
    lazy var experienceFetch: NSFetchedResultsController<Experience> = {
        return Experience.fetchExperiencesObject(delegate: objHome as Any)
    }()
    
    /// Row count
    func getRowCount() -> Int {
        return experienceFetch.fetchedObjects!.count
    }
    
    /// Get Row data
    func getDataForRow(index:Int) -> Experience {
        return experienceFetch.fetchedObjects![index]
    }
    
    ///Change Current Currencie Type
    func setNewCurrencie(quote: Float, currencieType:String) -> Void {
        objExperiences!.currentCurrencieValues = quote
        objExperiences!.currentCurrencieType = currencieType
        self.updateStore()
    }
    
    func updateStore() {
        //Update in Database
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = CoreDataManager.shared.persistentContainer.viewContext
        privateMOC.performAndWait {
            Experience.updateCurrency(objExperiences: self.objExperiences!, context: privateMOC)
        }
    }
    /// Get Experiences List
    func getExperiencesList() -> Void {
        BaseReqeustClass.GETRequset(apiName: apiName.experiences, url: apiURL.s3URL, showLoader: true, responseModel: Mapper<Experiences>()) { (reponce) in
            self.objExperiences = reponce as? Experiences
            
             //Stored in Database
            let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateMOC.parent = CoreDataManager.shared.persistentContainer.viewContext
            privateMOC.performAndWait {
                Experience.saveExperience(objExperiences: self.objExperiences!, context: privateMOC)
                
                //Get the update price
                self.getUpdatedCurrenciesPrice()
            }
        }
    }
    
    /// Webservice Currencie Price
    func getUpdatedCurrenciesPrice() -> Void {
        BaseReqeustClass.GETRequset(apiName: apiName.none, url: apiURL.apilayerURL, showLoader: true, responseModel: Mapper<Currencies>()) { (reponce) in
            var objCurrencies: Currencies = (reponce as? Currencies)!
            
            let objExperience: Experience = Experience.experienceObject(id: self.experienceFetch.fetchedObjects!.first!.id, context: CoreDataManager.shared.persistentContainer.viewContext)
            
            self.objExperiences!.currentCurrencieValues = Float("\(String(describing: objCurrencies.currenciesQuotes!["USD\(String(describing:objExperience.currencyType!))"]!))")!
            self.objExperiences!.currentCurrencieType = objExperience.currencyType!
            
            //Update Database
            self.updateStore()

        }
    }
}
