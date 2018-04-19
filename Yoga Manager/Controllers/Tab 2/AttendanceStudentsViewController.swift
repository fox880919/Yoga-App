//
//  AttendanceStudentsViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 12/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class AttendanceStudentsViewController: UIViewController {
    
    var selectedGroupStudents: [Student]!
    
    var selectedStudents = [Student]()
    
    var allCells = [AttendanceStudentCell]()
    
    var selectedCells = [AttendanceStudentCell]()
    
    var selectedGroup: Group!
    
    var selectedSession : Session!
    
    var defaultColor : UIColor?
    
    let attendanceViewModel = AttendanceModelView()
    
    var subscriptions: [StudentSubscription]!
    
    @IBOutlet weak var studentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
        
        self.navigationItem.rightBarButtonItem = saveBtn
        
        studentsCollectionView.dataSource = self
        studentsCollectionView.delegate = self
        
        subscriptions = StudentSubscriptionViewModel().getGroupSubscriptions(studentsGroup: selectedGroup)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @objc func saveBtnPressed()
    {
        
        let date = getDayDate(date: Date())
        
        var i = 0
        
        let allStudent = StudentViewModel().getGroupStudents(studentsGroup: selectedGroup)
        
        
        
        for student in allStudent {
            
            
            let count = allCells.count
            let isPaid = allCells[i].isPaidCheckBox.on
            
            let testName = allCells[i].studentNameLabel


            i = i + 1;

            
            if (selectedStudents.contains(student))
            {

                
                attendanceViewModel.addANewAttendance(attendanceDate: date, isPaid: isPaid, attended: true, student: student, session: selectedSession, group: selectedGroup)
                

            }

            else{
                
                attendanceViewModel.addANewAttendance(attendanceDate: date, isPaid: isPaid, attended: false, student: student, session: selectedSession, group: selectedGroup)

            }
            
            

        }
        
//        for student in selectedStudents {
//
//
//        }
        
        navigationController?.popViewController(animated: true)

    }
    
}

extension AttendanceStudentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        
        return selectedGroupStudents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttendanceStudentCell", for: indexPath)
            as! AttendanceStudentCell
        
        allCells.append(cell)

        if defaultColor == nil {
            defaultColor = cell.backgroundColor
        }
        
        
        //  cell.isPaidCheckBox.isEnabled = false
        // Configure the cell
        
        let rowStudent = selectedGroupStudents[indexPath.row]
        
        cell.studentNameLabel.text! = rowStudent.name!
        
        
        for subscription in subscriptions {
            
            if(subscription.student == rowStudent)
            {
                if(DateFromString(dateString: subscription.end_date!)  >= Date())
                {
                    
                    cell.isPaidCheckBox.on = true
                    
                    break
                }
                
            }
            
            
        }
     
        
        if let image = UIImage(data: selectedGroupStudents[indexPath.row].photo!)
        {
            cell.studentImage.image! = image
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedStudent = selectedGroupStudents[indexPath.row]
        
        let cell = collectionView.cellForItem(at: indexPath) as! AttendanceStudentCell
        
        
        if(selectedStudents.contains(selectedStudent))
        {
            cell.backgroundColor = defaultColor
            
            cell.isPaidCheckBox.isHidden = true
            
            selectedStudents.remove(at: selectedStudents.index(of: selectedStudent)!)
            selectedCells.remove(at: selectedCells.index(of: cell)!)
            
            
        }
        else{
            
            selectedCells.append(cell)
            
            selectedStudents.append(selectedStudent)
            
            
            cell.isPaidCheckBox.isHidden = false
            
            
            for subscription in subscriptions {
                
                if(subscription.student == selectedStudent)
                {
                    if(DateFromString(dateString: subscription.start_date!)  <= Date() && DateFromString(dateString: subscription.end_date!)  >= Date())
                    {
                        
                        cell.isPaidCheckBox.on = true
                        
                        cell.backgroundColor = UIColor.cyan

                        break
                    }

                }
                
                if (cell.isPaidCheckBox.on == false)
                {
                 
                    cell.backgroundColor = UIColor.orange
                }
                
            }
            
            //collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.cyan
            
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
    
}
