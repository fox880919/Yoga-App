//
//  AttendanceStudentCell.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 13/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class AttendanceStudentCell : UICollectionViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentNameLabel: UILabel!
    
    @IBOutlet weak var isPaidCheckBox: BEMCheckBox!
    
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
            
            isPaidCheckBox.delegate = self
        }
    }
    
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.on == true {
            
            self.backgroundColor = UIColor.cyan
        }
        
            else{
            
            self.backgroundColor = UIColor.orange
            
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.studentImage.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        
        self.studentImage.layer.cornerRadius = CGFloat(roundf(Float(self.studentImage.frame.size.width / 2.0)))
    }
    
    
}

