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

var isArabic: Bool {
    
    get{
       
        let isArabic = defaults.bool(forKey: "isArabic")
        
        return isArabic

    }
}



func saveTheme(isThemeLight: Bool)
{
    if (isThemeLight)
    {
        defaults.set(true, forKey: "isThemeLight")
        
    }
    else{
        defaults.set(false, forKey: "isThemeLight")
        
    }
}

var isThemeLight : Bool {
    
    get{
     
        let isThemeLight = defaults.bool(forKey: "isThemeLight")
        
        return isThemeLight
    }
}


extension UIView {
    func toImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

