//
//  Colors.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 23/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation


    
    private let _buttonColor = UIColor(red:1.00, green:0.87, blue:0.97, alpha:1.0)

    private let _buttonFontColor = UIColor.blue


    private let _exPecondaryColor = UIColor(red:0.40, green:0.88, blue:0.97, alpha:1.0)

    
    private let _primaryColor = UIColor(red:0.07, green:0.18, blue:0.24, alpha:1.0)
    
    private let _secondaryColor = UIColor(red:0.42, green:0.71, blue:0.76, alpha:1.0)

   // private let _lightPrimaryColor = UIColor(red:0.27, green:0.34, blue:0.39, alpha:1.0)

    private let _lightPrimaryColor = UIColor(red:0.07, green:0.18, blue:0.24, alpha:1.0)


    private let _secondPrimaryColor = UIColor(red:0.94, green:0.97, blue:0.98, alpha:1.0)

    private let _secondSecondaryColor = UIColor(red:0.94, green:0.97, blue:0.98, alpha:1.0)

    private let _lightSecondPrimaryColor = UIColor(red:0.94, green:0.97, blue:0.98, alpha:1.0)



    public var  primaryColor: UIColor{
    get{
        if(isThemeLight)
        {
         
            return _secondPrimaryColor
        }
        
        return _primaryColor
    }
}

    public var  secondaryColor: UIColor{
    get{
        if(isThemeLight)
        {
            
            return _secondSecondaryColor
        }
        
        return _secondaryColor
    }
}
        
public var  lightPrimaryColor: UIColor{
    get{
        if(isThemeLight)
        {
            
            return _lightSecondPrimaryColor
        }
        
        return _lightPrimaryColor
    }
}
    
    public var  buttonColor: UIColor{
        
        get{
            if(isThemeLight)
            {
                
                return _buttonColor
                
            }
            return _buttonColor
            
        }
}

public var  buttonFontColor: UIColor{
    
    get{
        if(isThemeLight)
        {
            
            return _buttonFontColor
            
        }
        return _buttonFontColor
        
    }
}

