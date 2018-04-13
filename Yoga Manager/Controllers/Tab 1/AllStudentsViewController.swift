//
//  AllStudentsViewController.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/1/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class AllStudentsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var allStudentsCollectionView: UICollectionView!
    
    var studentViewModel = StudentViewModel()
    
    var registeredStudents : [Student]?

    var allStudents : [Student]!
    
    var selectedStudents = [Student]()
    
    var studentsGroup : Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        allStudentsCollectionView.dataSource = self
        allStudentsCollectionView.delegate = self
        
          allStudentsCollectionView.roundCorners([.topLeft,.topRight], radius: 5)

        filterStudents()
        
        allStudentsCollectionView.allowsMultipleSelection = false

        // Do any additional setup after loading the view.
        
       // allStudentsCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterStudents()
    {
        allStudents = studentViewModel.getAllStudents()
        
        if let registeredStudents = registeredStudents {
            
            var unregisterdStudents = [Student]()
            
            for student in allStudents {
                
                if !(registeredStudents.contains(student))
                {
                    unregisterdStudents.append(student)
                }
            }
            allStudents = unregisterdStudents
            
        }
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        
        return allStudents.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allStudentCell1", for: indexPath)
            as! GroupStudentCell
        
        
        // Configure the cell
        
        cell.studentNameLabel.text! = allStudents[indexPath.row].name!
        
        if let image = UIImage(data: allStudents[indexPath.row].photo!)
        {
            cell.studentImage.image! = image
        }
        
        return cell
    }

    
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let selectedStudent = allStudents[indexPath.row]
        
        if(selectedStudents.contains(selectedStudent))
        {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
            
            selectedStudents.remove(at: selectedStudents.index(of: selectedStudent)!)
        }
        else{
            
            selectedStudents.append(selectedStudent)
            
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.cyan

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 10))/2, height: 220)
        return cellSize
        
        //return CGSize(width: (collectionView.frame.width/2) - 5, height: collectionView.frame.width/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        return sectionInset
    }

    @IBAction func cancelBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
        for student in selectedStudents {
            
            studentViewModel.addExistingStudent(student: student, studentsGroup: studentsGroup)
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//
extension UICollectionView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }}

