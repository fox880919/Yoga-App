//
//  LanguageStrings.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 25/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation

class LangaugeStrings {
    
    public var AppTitle: String {
        
        return ""
    }
    
    public var GroupTitle: String {
        
        return ""
    }
    
    public var GroupCellSessionTitle: String {
        
        return ""
    }
    
    public var GroupCellStudentTitle: String {
        
        return ""
    }
    
    public var GroupCellAddNewTitle: String {
        
        return ""
    }
    
    
    
}

 var langauageStrings: LangaugeStrings {
    
    get{
        if(isArabic)
        {
            
            return arabicLanguage()
        }
        
        return englishLanguage()
    }
}

class englishLanguage: LangaugeStrings {

    override var AppTitle: String {
        
        return "Class Manager"
    }
    
    override var GroupTitle : String {
        
        return "Groups"
    }
    
    override var GroupCellSessionTitle: String {
        
        return "Sessions"
    }
    
    override var GroupCellStudentTitle: String {
        
        return "Students"
    }
    
    override var GroupCellAddNewTitle: String {
        
        return "Add a New group"
    }

}


class arabicLanguage: LangaugeStrings {
    
    override var AppTitle: String {
        
        return "منسق المجموعات"
    }
    
    override var GroupTitle : String {
        
        return "المجموعات"
    }
    
    override var GroupCellSessionTitle: String {
        
        return "الحصص"
    }
    
    override var GroupCellStudentTitle: String {
        
        return "الطلاب"
    }
    
    override var GroupCellAddNewTitle: String {
        
        return "أضف مجموعة جديدة"
    }


}
