//
//  BasicViewModel.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 31/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class BasicViewModel{
    
    
     var managedContext : NSManagedObjectContext!
    
    init() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        managedContext = appDelegate.persistentContainer.viewContext
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
