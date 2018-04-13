//
//  StudentViewModel.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 31/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StudentViewModel : BasicViewModel
{
    
    func getAllStudents() -> [Student]{
        
        let students = coreDataHelper.getEntities(entityName: "Student") as! [Student]
        
        return students
    }
    
    func getGroupStudents(studentsGroup: Group) -> [Student]{
        
        let students = coreDataHelper.getEntitiesWithPredicate(entityName: "Student", predicate: NSPredicate(format: "ANY groups == %@",studentsGroup)) as! [Student]
        
        return students
    }
    
    
    func addExistingStudent(student: Student, studentsGroup: Group)
     {
        student.addToGroups(studentsGroup)
        
        saveData()
    }
    
    func addANewStudent(studentName: String!, studentEmail: String!, studentAddress: String!, studentPhone: String!
        , studentPhoto: UIImage, studentDateOfBirth: Date, studentIsMale: Bool, studentGroup: Group){
        
        let newStudent = Student(context: managedContext)
  
        newStudent.name = studentName
        newStudent.email = studentEmail
        newStudent.address = studentAddress
        newStudent.phone = studentPhone
        newStudent.photo = UIImagePNGRepresentation(studentPhoto)
        newStudent.date_of_birth = studentDateOfBirth
        newStudent.gender_ismale = studentIsMale
        newStudent.addToGroups(studentGroup)
        
        saveData()
        
    }
    
    func deleteAstudent(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
        
        saveData()

    }
    
    func removeGroup(student: Student, studentGroup: Group){
        
        student.removeFromGroups(studentGroup)
        
        saveData()

    }
    
    func updateAStudent(oldStudent: Student, studentName: String!, studentEmail: String!, studentAddress: String!, studentPhone: String!
        , studentPhoto: UIImage, studentDateOfBirth: Date, studentIsMale: Bool)
    {
        
        oldStudent.setValue(studentName, forKey: "name")
        oldStudent.setValue(studentPhone, forKey: "phone")
        oldStudent.setValue(studentEmail, forKey: "email")
        oldStudent.setValue(studentIsMale, forKey: "gender_ismale")
        oldStudent.setValue(studentDateOfBirth, forKey: "date_of_birth")
        oldStudent.setValue(studentAddress, forKey: "address")

        
        let imageData = UIImagePNGRepresentation(studentPhoto)
        oldStudent.setValue(imageData, forKey: "photo")

        super.saveData()
    }
}
