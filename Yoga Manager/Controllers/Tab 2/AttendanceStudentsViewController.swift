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
    
    var newInputView : UIView!

    var isPickersViewOn = false

    var DayDatePicker = UIPickerView()
    
    var pickerArray: [String]!
    
    var attendanceDate: String!


    
    @IBOutlet weak var studentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
        
        self.navigationItem.rightBarButtonItem = saveBtn
        
        studentsCollectionView.dataSource = self
        studentsCollectionView.delegate = self
        

        
        subscriptions = StudentSubscriptionViewModel().getGroupSubscriptions(studentsGroup: selectedGroup)
        
        // Do any additional setup after loading the view.
        
        pickerArray = getArrayOfWeekDays(weekDay: Date.Weekday(rawValue: selectedSession.week_day!.lowercased())!, numberOfForwardDays: 0, numberOfBackwardDays: 4)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        subscriptions = StudentSubscriptionViewModel().getGroupSubscriptions(studentsGroup: selectedGroup)
        
        // Do any additional setup after loading the view.
        
        pickerArray = getArrayOfWeekDays(weekDay: Date.Weekday(rawValue: selectedSession.week_day!.lowercased())!, numberOfForwardDays: 0, numberOfBackwardDays: 4)
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

        if(isPickersViewOn == true)
        {
        }
        else{
            
            isPickersViewOn = true
            
            newInputView = UIView(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: 120))
            
            let DayDateLbl = UILabel(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width, height: 20))
            
            DayDateLbl.textAlignment = .center
            
            DayDateLbl.text = "Which \(selectedSession.week_day!)"
            
            DayDatePicker = UIPickerView(frame:CGRect(x: 10, y: 40, width: self.view.frame.size.width - 20, height: 50))
            
            DayDatePicker.delegate = self
            DayDatePicker.dataSource = self
            
            DayDatePicker.backgroundColor = UIColor.white
            
            DayDatePicker.showsSelectionIndicator = true
            
            DayDatePicker.selectRow(pickerArray.count - 1, inComponent: 0, animated: false)
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePickingDate))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelView))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            
            toolBar.isUserInteractionEnabled = true
            
            newInputView.addSubview(toolBar)
            
            newInputView.addSubview(DayDateLbl)
            
            newInputView.addSubview(DayDatePicker)
            
            newInputView.backgroundColor = UIColor.cyan
            
            self.view.addSubview(newInputView)
            
        }
     
    }
    
   func saveAttendance(){
    
    var i = 0
    
    let allStudent = StudentViewModel().getGroupStudents(studentsGroup: selectedGroup)
    
    attendanceDate = pickerArray[DayDatePicker.selectedRow(inComponent: 0)]
    
    for student in allStudent {
        
        let isPaid = allCells[i].isPaidCheckBox.on
        
        i = i + 1;
        
        
        if (selectedStudents.contains(student))
        {
            
            
            attendanceViewModel.addANewAttendance(attendanceDate: attendanceDate, isPaid: isPaid, attended: true, student: student, session: selectedSession, group: selectedGroup)
            
        }
            
        else{

            attendanceViewModel.addANewAttendance(attendanceDate: attendanceDate, isPaid: isPaid, attended: false, student: student, session: selectedSession, group: selectedGroup)
            
        }
        
    }
    
    navigationController?.popViewController(animated: true)
    
    }
    
    @objc func donePickingDate(){
        
        saveAttendance()

    }
    
    @objc func cancelView(){
        
        isPickersViewOn = false
        
        DayDatePicker.resignFirstResponder()
        
    newInputView.removeFromSuperview()
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
            
            
            if(subscriptions.count > 0)
            {
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
            }
            else{
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


extension AttendanceStudentsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerArray.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerArray[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        attendanceDate = pickerArray[row]
        
    }
}
