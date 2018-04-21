//
//  MainViewModel.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 27/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainViewModel : BasicViewModel
{
    
    
    func getGroups() -> [Group]{
        
       let groups = coreDataHelper.getEntities(entityName: "Group") as! [Group]
        
        return groups
    }
    
    
    func addANewGroup(groupName: String!, sessionPrice: Int , subscriptionPrice: Int){
        
        var attributes = [String : Any]()
        
        attributes["name"] = groupName
    
        attributes["session_price"] = sessionPrice
        
        attributes["subscription_price"] = subscriptionPrice
        
        coreDataHelper.createNewEntity(entityName: "Group", attributes: attributes)
        
        saveData()
    }
    
    func deleteAGroup(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
    }
    
    func updateAgroup(oldGroup: Group, newName: String!, newSessionPrice: Int , newSubscriptionPrice: Int)
    {
        oldGroup.setValue(newName, forKey: "name")
        
        oldGroup.setValue(newSessionPrice, forKey: "session_price")
        
        oldGroup.setValue(newSubscriptionPrice, forKey: "subscription_price")
       
        super.saveData()
    }
    
}
