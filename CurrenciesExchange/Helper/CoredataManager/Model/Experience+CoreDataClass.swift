//
//  Experience+CoreDataClass.swift
//  CurrenciesExchange
//
//  Created by Niraj on 01/07/19.
//  Copyright © 2019 Niraj. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Experience)
public class Experience: NSManagedObject {
    
    class func saveExperience(objExperiences:Experiences, context: NSManagedObjectContext) {
        
        for objExperiencesList in objExperiences.experiences! {
            if Experience.isExitId(id:Int32(objExperiencesList.id!), context: context) {
                let objExperience: Experience = Experience.experienceObject(id: Int32(objExperiencesList.id!), context: context)
                objExperience.title = objExperiencesList.title!
                objExperience.id = Int32(objExperiencesList.id!)
                objExperience.imgURL = URL.init(string: objExperiencesList.image!)
                
            }else{
                let objExperience: Experience! = (NSEntityDescription.insertNewObject(forEntityName: "Experience", into: context) as! Experience)
                objExperience.title = objExperiencesList.title!
                objExperience.id = Int32(objExperiencesList.id!)
                objExperience.currencyType = objExperiences.currentCurrencieType
                objExperience.cost = ((Float(objExperiencesList.price_usd_cents!) / 100.0) * objExperiences.currentCurrencieValues)
                objExperience.imgURL = URL.init(string: objExperiencesList.image!)
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    class func updateCurrency(objExperiences:Experiences, context: NSManagedObjectContext) {
        for objExperiencesList in objExperiences.experiences! {
            if Experience.isExitId(id:Int32(objExperiencesList.id!), context: context) {
                let objExperience: Experience = Experience.experienceObject(id: Int32(objExperiencesList.id!), context: context)
                objExperience.currencyType = objExperiences.currentCurrencieType
                objExperience.cost = ((Float(objExperiencesList.price_usd_cents!) / 100.0) * objExperiences.currentCurrencieValues)
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    //Check ID in DB
    class func isExitId(id:Int32, context: NSManagedObjectContext) -> Bool {
        let request = NSFetchRequest<Experience>(entityName: NSStringFromClass(Experience.self))
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        
        let results: [Experience] = try! context.fetch(request)
        if results.count > 0 {
            return true
        }
        return false
    }
    
    //Return avalable object
    @objc class func experienceObject(id:Int32, context: NSManagedObjectContext) -> Experience {
        
        let request = NSFetchRequest<Experience>(entityName: NSStringFromClass(Experience.self))
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        
        let results: [Experience] = try! context.fetch(request)
        if results.count > 0 {
            return results[0]
        }
        return Experience()
    }
    
    class func fetchExperiencesObject(delegate:Any) -> NSFetchedResultsController<Experience> {
        
        let request = NSFetchRequest<Experience>(entityName: NSStringFromClass(Experience.self))
        request.sortDescriptors = [NSSortDescriptor(key:"id", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: "id", cacheName: nil)
        fetchedResultsController.delegate = (delegate as! NSFetchedResultsControllerDelegate)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
        
        return fetchedResultsController
    }
}
