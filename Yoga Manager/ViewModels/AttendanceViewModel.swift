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
    func getAllAttendance() -> [Attendance]{
        
        let attendance = coreDataHelper.getEntities(entityName: "Attendance") as! [Attendance]
        
        return attendance
    }
    
    
    func addANewAttendance (attendanceDate: String,  isPaid: Bool, attended: Bool, student : Student, session: Session, group: Group){
        
        let attendance = Attendance(context: managedContext)
        
        attendance.attendance_date = attendanceDate
        
        attendance.attended = attended
        
        attendance.is_paid = isPaid
        
        attendance.student = student
        
        attendance.week_day = session.week_day
        
        attendance.start_time = session.start_time
        
        attendance.end_time = session.end_time
        
        attendance.group = group
        saveData()
        
    }
    
    func updateAnAttendance (attendance: Attendance, attendanceDate: Date,  isPaid: Bool, attended: Bool){
        
        attendance.setValue(attendanceDate, forKey: "attendance_date")
        
        attendance.setValue(isPaid, forKey: "attended")
        
        attendance.setValue(attended, forKey: "is_paid")
        
        saveData()
        
    }
    
    func deleteAnAttendance(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
        
        saveData()
        
    }
    
}

