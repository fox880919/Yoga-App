//
//  LanguageStrings.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 25/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation

class LangaugeStrings {
    
    // ViewController

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
    
    // SettingsView
    
    
    public var settingsitle: String {
        
        return ""
    }
    
    public var AllLocationsListTitle: String {
        
        return ""
    }
    
    public var ThemeLblTitle: String {
        
        return ""
    }
    
    public var langaugeLblTitle: String {
        
        return ""
    }
    

    public var DarkThemeSegmentTitle1: String {
        
        return ""
    }
    
    public var DarkThemeSegmentTitle2: String {
        
        return ""
    }
    
    public var addressLbl: String {
        
        return ""
    }
    
    public var coordinatesLbl: String {
        
        return ""
    }
    
    // AddingGroupView
    
    public var addingGroupTitle: String {
        
        return ""
    }
    
    public var subscriptionPriceTitle: String {
        
        return ""
    }
    
    public var sessionPriceTitle: String {
        
        return ""
    }
    
    public var cancelButtonTitle: String {
        
        return ""
    }
    
    public var submitButtonTitle: String {
        
        return ""
    }
    
    // SelectedGroupView
    
    
    
    public var studentsSectionTitle: String {
        
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
    
    override var settingsitle: String {
        
        return "Settings"
    }
    
    override var AllLocationsListTitle: String {
        
        return "All-Locations List:"
    }
    
    
    override var langaugeLblTitle: String {
        
        return "Langauge:"
    }
    
    override var ThemeLblTitle: String {
        
        return "Theme:"
    }
    
    override var DarkThemeSegmentTitle1: String {
        
        return "Dark"
    }
    
    override var DarkThemeSegmentTitle2: String {
        
        return "Light"
    }
    
    override var addressLbl: String {
        
        return "Address"
    }
    
    override var coordinatesLbl: String {
        
        return "Coordinates"
    }
    
    override var addingGroupTitle: String {
        
        return "Adding a new group"
    }
    
    override var subscriptionPriceTitle: String {
        
        return "Subscription Price:"
    }
    
    override var sessionPriceTitle: String {
        
        return "Session Price:"
    }
    
    
    override var cancelButtonTitle: String {
        
        return "Cancel"
    }
    
    override var submitButtonTitle: String {
        
        return "Submit"
    }
    
    override var studentsSectionTitle: String {
        
        return "Students"
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
    
    override var settingsitle: String {
        
        return "الإعدادات "
    }
    override var AllLocationsListTitle: String {
        
        return "قائمة المواقع"
    }
    
    override var langaugeLblTitle: String {
        
        return ":اللغة"
    }
    
    override var ThemeLblTitle: String {
        
        return ":الألوان"
    }
    
    override var DarkThemeSegmentTitle1: String {
        
        return "داكن"
    }
    
    override var DarkThemeSegmentTitle2: String {
        
        return "فاتح"
    }
    
    
    override var addressLbl: String {
        
        return ":العنوان"
    }
    
    override var coordinatesLbl: String {
        
        return "الاحداثيات"
    }
    
    
    
    override var addingGroupTitle: String {
        
        return "أضافة مجموعة جديدة"
    }
    
    override var subscriptionPriceTitle: String {
        
        return "الاشتهراك الشهري:"
    }
    
    override var sessionPriceTitle: String {
        
        return "سعر الحصة:"
    }
    
    
    override var cancelButtonTitle: String {
        
        return "إلغاء"
    }
    
    override var submitButtonTitle: String {
        
        return "تنفيذ"
    }
    
    
    override var studentsSectionTitle: String {
        
        return "الطلبة"
    }

}
