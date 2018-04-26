//
//  GroupTableCell.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 3/29/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class GroupTableCell : UITableViewCell {
    
    @IBOutlet weak var sessionTitleLbl: UILabel!
    
    @IBOutlet weak var cellTitleLbl: UILabel!
    
    @IBOutlet weak var studentsTitleLbl: UILabel!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var studentsLabel: UILabel!
    
    @IBOutlet weak var sessionsLabel: UILabel!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.backgroundView?.backgroundColor = UIColor.red
//
//        groupNameLabel.backgroundColor =  secondaryColor
//
//        studentsLabel.backgroundColor =  secondaryColor
//
//        sessionsLabel.backgroundColor =  secondaryColor
        
        //groupNameLabel.textColor =  lightPrimaryColor
        
        studentsLabel.textColor =  lightPrimaryColor
        
        sessionsLabel.textColor =  lightPrimaryColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       // fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
      //  self.backgroundView?.backgroundColor = primaryColor
        
     //   self.backgroundColor = primaryColor

        
        self.contentView.backgroundColor = secondaryColor
            
        
        sessionTitleLbl.backgroundColor = secondaryColor
        
        studentsTitleLbl.backgroundColor = secondaryColor
        
        studentsLabel.backgroundColor = secondaryColor
        
        sessionsLabel.backgroundColor = secondaryColor
        
        cellTitleLbl .backgroundColor = secondaryColor
        
        
        cellTitleLbl.textColor = primaryColor
        
        sessionTitleLbl.textColor = primaryColor
        
        studentsTitleLbl.textColor = primaryColor

        studentsLabel.textColor =  UIColor.blue
        
        sessionsLabel.textColor =  UIColor.blue
        
        sessionTitleLbl.text = langauageStrings.GroupCellSessionTitle
        
        studentsTitleLbl.text = langauageStrings.GroupCellStudentTitle
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
