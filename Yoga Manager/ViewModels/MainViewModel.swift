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
    
    
    func addANewGroup(groupName: String!, sessionPrice: Int){
        
        var attributes = [String : Any]()
        
        attributes["name"] = groupName
    
        attributes["session_price"] = sessionPrice
        
        coreDataHelper.createNewEntity(entityName: "Group", attributes: attributes)
    }
    
    func deleteAGroup(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
    }
    
    func updateAgroup(oldGroup: Group, newName: String!)
    {
        oldGroup.setValue(newName, forKey: "name")
                
        super.saveData()
    }
    
}
