//
//  CoreDataHelper.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 27/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let coreDataHelper = CoreDataHelper()

class CoreDataHelper {
    
    private var managedContext : NSManagedObjectContext!
    
    init() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getEntities (entityName : String!) -> [Any]
    {
        let entityFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        var result = [Any]()

        do {
            
             let entities = try managedContext.fetch(entityFetch)
            
                result = entities
        }
        
        catch {
            print("Unable to fetch managed objects for entity \(entityName).")
        }
        
        return result
        
    }
    
    func getEntitiesWithPredicate (entityName : String!, predicate: NSPredicate) -> [Any]
    {
        let entityFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        entityFetch.predicate = predicate
        
        var result = [Any]()
        
        do {
            
            let entities = try managedContext.fetch(entityFetch)
            
            result = entities
        }
            
        catch {
            print("Unable to fetch managed objects for entity \(entityName).")
        }
        
        return result
        
    }
    
    func createNewEntity(entityName : String!, attributes : [String : Any])
    {
        let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
        
        if let newEntity = newEntity {
            
        let newEntityObject = NSManagedObject(entity: newEntity, insertInto: managedContext)
            for (key, value) in attributes {
                
                newEntityObject.setValue(value, forKey: key)
            }
        }
        
        saveData()
    }
    
    func deleteAnEntity(entity: NSManagedObject)
    {
        managedContext.delete(entity)
        
        saveData()
    }
    
    func saveData()
    {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
 
}

