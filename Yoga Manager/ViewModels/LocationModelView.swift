//
//  LocationModelView.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 10/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocationModelView : BasicViewModel
{
    
    func getAllLocations() -> [Location]{
        
        let locations = coreDataHelper.getEntities(entityName: "Location") as! [Location]
        
        return locations
    }
    

    func addExistingLocation(location: Location, session: Session)
    {
        session.location = location
        
        saveData()
    }
    
    func addANewLocation (name: String,  latitude: String, longitude : String, address: String)  -> Location {
        
        let location = Location(context: managedContext)
        
        location.name = name
        
        location.latitude = latitude
        location.longitude = longitude
        location.address = address
        
        return location
    }
    
    func updateALocation (location: Location, name: String,  latitude: String, longitude : String, address: String){
        
        location.setValue(name, forKey: "name")
        
        location.setValue(latitude, forKey: "latitude")
        
        location.setValue(longitude, forKey: "longitude")
        
        location.setValue(address, forKey: "address")
        
        saveData()
        
    }
    
    func deleteALocation(entity: NSManagedObject){
        
        coreDataHelper.deleteAnEntity(entity: entity)
        
        saveData()
        
    }
}
