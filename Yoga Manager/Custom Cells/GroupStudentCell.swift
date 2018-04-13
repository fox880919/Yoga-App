//
//  GroupStudentCell.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 30/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class GroupStudentCell : UICollectionViewCell {
    
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentNameLabel: UILabel!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
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
