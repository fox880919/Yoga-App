//
//  LocationTableCell.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/12/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class LocationTableCell : UITableViewCell {
    
    @IBOutlet weak var locationNameLbl: UILabel!
    
    @IBOutlet weak var addressTitleLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var coordinatestTtleLbl: UILabel!
    @IBOutlet weak var googleUrlLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressLbl.text = langauageStrings.addressLbl
        
        coordinatestTtleLbl.text = langauageStrings.coordinatesLbl
        
        locationNameLbl.textColor =  UIColor.blue
        
        addressLbl.textColor =  UIColor.blue
        
        googleUrlLbl.textColor =  UIColor.blue
    }
    
}

