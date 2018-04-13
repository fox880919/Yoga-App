//
//  AttendanceViewModel.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/12/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AttendanceModelView : BasicViewModel
{
    func getAllAttendance() -> [Location]{
        
        let locations = coreDataHelper.getEntities(entityName: "Location") as! [Location]
        
        return locations
    }
    

    func addANewAttendance (attendanceDate: Date,  isPaid: Bool, attended: Bool, student : Student, session: Session){
        
        let attendance = Attendance(context: managedContext)
        
        attendance.attendance_date = attendanceDate
        
        attendance.attended = attended
        
        attendance.is_paid = isPaid
        
        attendance.student = student
        
        attendance.session = session
 
        saveData()
        
    }
    
    func updateAnAt (attendance: Attendance, attendanceDate: Date,  isPaid: Bool, attended: Bool){
        
        attendance.setValue(attendanceDate, forKey: "attendance_date")
        
        attendance.setValue(isPaid, forKey: "attended")
        
        attendance.setValue(attended, forKey: "is_paid")
        
        saveData()
        
    }
    
    func deleteALocation(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
        
        saveData()
        
    }
    
}
