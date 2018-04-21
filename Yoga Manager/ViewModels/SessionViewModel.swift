//
//  SessionViewModel.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 04/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SessionViewModel  : BasicViewModel
{
    
    func getAllSessions() -> [Session]{

        let sessions = coreDataHelper.getEntities(entityName: "Session") as! [Session]

        return sessions
    }

    func getGroupSessions(studentsGroup: Group) -> [Session]{

        let sessions = coreDataHelper.getEntitiesWithPredicate(entityName: "Session", predicate: NSPredicate(format: "ANY groups == %@",studentsGroup)) as! [Session]

        return sessions
    }
    
    func getLocationSessions(location: Location) -> [Session]{
        
        let sessions = coreDataHelper.getEntitiesWithPredicate(entityName: "Session", predicate: NSPredicate(format: "ANY locations == %@",location)) as! [Session]
        
        return sessions
    }

    func addExistingSession(session: Session, sessionGroup: Group)
    {
        session.addToGroups(sessionGroup)

        saveData()
    }

    func addANewSession (cost: Int, day : String, startTime: Date, endTime: Date, createdDate: Date, isWeekly: Bool,  sessionGroup: Group) -> Session{
  
       let session = Session(context: managedContext)

        session.cost = Int16(cost)

//        session.session_time = SessionDate(day: day, starttime: startTime, endTime: endDate)

        session.start_time = stringFromTime(date: startTime)
        session.end_time = stringFromTime(date: endTime)
        session.week_day = day
        session.created_date = createdDate
        session.is_weekly = isWeekly
        
        session.addToGroups(sessionGroup)
        
        return session

    }

    func updateASession (cost: Int, day : String, startTime: Date, endTime: Date, isWeekly: Bool, currentSession: Session){

        // let newSessionDate = SessionDate(day: day, starttime: startTime, endTime: endDate)
        
        let newcost = Int16(cost)

        if currentSession.is_weekly == true && isWeekly == false {
            
            currentSession.setValue(Date(), forKey: "created_date")
        }
        
        currentSession.setValue(newcost, forKey: "cost")

        currentSession.setValue(stringFromTime(date: startTime), forKey: "start_time")
        
        currentSession.setValue(stringFromTime(date: endTime), forKey: "end_time")
        
        currentSession.setValue(day, forKey: "week_day")
        
        currentSession.setValue(isWeekly, forKey: "is_weekly")

    }

    func deleteASession(entity: NSManagedObject){

        coreDataHelper.deleteAnEntity(entity: entity)

        saveData()

    }

}
