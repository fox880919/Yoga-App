//
//  Student.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 27/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation

class StudentModel {
    
    private var _name: String!
    
    private var _number: String!
    
    
     init(name: String!, number: String!)
     {
        _name = name
        _number = number
    }
    
    var name: String {
        get {
            return self._name
        }
    }
    
    var number: String {
        get {
            return self._number
        }
    }
}
