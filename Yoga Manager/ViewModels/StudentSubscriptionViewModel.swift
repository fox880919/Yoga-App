//
//  SubscriptionViewModel.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/18/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import CoreData

class StudentSubscriptionVIewModel : BasicViewModel{
    
    func getSubscriptions() -> [StudentSubscription]{
        
        let subscriptions = coreDataHelper.getEntities(entityName: "StudentSubscription") as! [StudentSubscription]
        
        return subscriptions
    }
    
    func getGroupSubscriptions(studentsGroup: Group) -> [StudentSubscription]{
        
        let subscriptions = coreDataHelper.getEntitiesWithPredicate(entityName: "StudentSubscription", predicate: NSPredicate(format: "ANY group == %@",studentsGroup)) as! [StudentSubscription]
        
        return subscriptions
    }
    
    
    func addANewSubscription(startDate: Date , endDate: Date, student: Student, group: Group){
        
        let subscription = StudentSubscription(context: managedContext)

        subscription.start_date = stringFromDate(date: startDate)
        subscription.end_date = stringFromDate(date: endDate)
        
        subscription.group = group

        subscription.student = student
        
        saveData()
    }
    
    func updateASubscrtiption(subscription: StudentSubscription, startDate: Date , endDate: Date)
    {
        subscription.setValue(startDate, forKey: "start_date")
        
        subscription.setValue(endDate, forKey: "end_date")
        
        super.saveData()
    }
    
    func deleteAGroup(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
    }
    
  
}
