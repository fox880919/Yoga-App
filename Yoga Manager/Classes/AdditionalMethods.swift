//
//  AdditionalMethods.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 11/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation


let defaults = UserDefaults.standard

func saveLang(isArabic: Bool)
{
    if (isArabic)
    {
        defaults.set(true, forKey: "isArabic")
        
    }
    else{
        defaults.set(false, forKey: "isArabic")
        
    }
}

func isArabic()-> Bool {
    
    let isArabic = defaults.bool(forKey: "isArabic")
    
    return isArabic
}


func getDayComponent (dayName: String) ->Int
{
    switch  dayName{
        
    case "Sunday":
        return 0;
        
    case "Monday":
        return 1;
        
    case "Tuesday":
        return 2;
        
    case "Wednesday":
        return 3;
        
    case "Thursday":
        return 4;
        
    case "Friday":
        return 5;
        
    case "Saturday":
        return 6;
        
        
    default:
        return 0;
    }
}

func getDayName (componentInt: Int) -> String{
    
    switch  componentInt{
        
    case 0:
        return "Sunday";
        
    case 1:
        return"Monday";
        
    case 2:
        return "Tuesday";
        
    case 3:
        return "Wednesday";
        
    case 4:
        return "Thursday";
        
    case 5:
        return "Friday";
        
    case 6:
        return "Saturday";
        
        
    default:
        return "Sunday";
    }
}

func stringFromTime(date : Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "HH:mm"
    
    let newDateString = dateFormatter.string(from: date)
    
    return newDateString
    
}

func timeFromString(dateString : String) -> Date {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "HH:mm"
    
    let date = dateFormatter.date(from: dateString)
    
    return date!
    
}

func stringFromDate(date : Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "dd/MM/yyyy"
    
    let newDateString = dateFormatter.string(from: date)
    
    return newDateString
    
}

func DateFromString(dateString : String) -> Date {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "dd/MM/yyyy"
    
    let date = dateFormatter.date(from: dateString)
    
    return date!
    
}

func getDayDate(date: Date) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    
    let result = formatter.string(from: date)
    
    return result
}

func getCustomizedMagneta() -> UIColor
{
    
    //        var red = self.view.backgroundColor?.cgColor.components![0]
    //
    //        var green = self.view.backgroundColor?.cgColor.components![1]
    //
    //        var blue = self.view.backgroundColor?.cgColor.components![2]
    //        var alpha = self.view.backgroundColor?.cgColor.components![3]

    
    let color = UIColor(red:0.99881380796432495, green:0.86392885446548462, blue:0.97910517454147339, alpha:0.97910517454147339)
    
    return color
}



