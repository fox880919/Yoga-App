//
//  HistoryViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 13/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let groups = MainViewModel().getGroups()
    
    let attendanceModelView = AttendanceModelView()
    
    let allAttendanceHistory = AttendanceModelView().getAllAttendance()
    
    var filteredAttendanceHistory: [Attendance]!
    
    var lastGroupBeforePicker: Group!
    
    var lastStudentBeforePicker: Student!
    
    var selectedGroup: Group!
    
    var selectedStudent: Student!

    let allGroups = MainViewModel().getGroups()
    
    let allStudents = StudentViewModel().getAllStudents()
    
    var isSortedByStudentType = false
    
    @IBOutlet weak var sortTextFieldPickerView: UITextField!
    
    @IBOutlet weak var sortTypeSegmentCntrl: UISegmentedControl!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var selectedAttendance: [Attendance]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredAttendanceHistory = allAttendanceHistory
        
        filteredAttendanceHistory.reverse()
        
        prepareTextFieldUiPicker()
        
        sortTypeSegmentCntrl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func prepareTextFieldUiPicker()
    {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.default
        toolBar.backgroundColor = UIColor.lightGray
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        sortTextFieldPickerView.inputAccessoryView = toolBar

    }
    
    @objc func cancelPicker()
    {
        if(isSortedByStudentType)
        {
            
            selectedStudent = lastStudentBeforePicker
        }
        else
        {
            
            selectedGroup = lastGroupBeforePicker
        }
        
        sortTextFieldPickerView.resignFirstResponder()
    }
    

   @objc func donePicker(_ sender: UIBarButtonItem) {
    
        filterTable()
        sortTextFieldPickerView.resignFirstResponder()

            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func segmentValueChanged() {
        
        if(sortTypeSegmentCntrl.selectedSegmentIndex == 0)
        {
            isSortedByStudentType = false
            
            selectedStudent = nil
        }
        else{
            
            isSortedByStudentType = true
            
            selectedGroup = nil
        }
        
        sortTextFieldPickerView.text! = ""
    }
    
    @IBAction func textDidEdittingBegun(_ sender: Any) {
        
        let thePicker = UIPickerView()
        thePicker.tag = 1000;
        sortTextFieldPickerView.inputView = thePicker
        
        thePicker.delegate = self
    }
    
    
    func filterTable()
    {
        if(isSortedByStudentType)
        {
            if(selectedStudent != nil)
            {
                
                filterByStudent(specificStudent: selectedStudent)
            }
            else {
                
                filteredAttendanceHistory = attendanceModelView.getAllAttendance()
                
                filteredAttendanceHistory.reverse()
                
                historyTableView.reloadData()
            }
        }
            
        else{
            
            if(selectedGroup != nil)
            {
                filterByGroup(specificGroup: selectedGroup)

                
            }
            else {
                
                filteredAttendanceHistory = attendanceModelView.getAllAttendance()
                
                filteredAttendanceHistory.reverse()
                
                historyTableView.reloadData()
            }

        }
    }
    
    func filterByStudent(specificStudent: Student) {
        
        filteredAttendanceHistory = [Attendance]()
        
        for record in allAttendanceHistory {
            
            if record.student == specificStudent
            {
                filteredAttendanceHistory.append(record)
            }
        }
        
        filteredAttendanceHistory.reverse()
        
        historyTableView.reloadData()
        
        // do something with results
    }
    
    func filterByGroup(specificGroup: Group) {
        
        filteredAttendanceHistory = [Attendance]()
        
        for record in allAttendanceHistory {
            
            if record.group == specificGroup
            {
                filteredAttendanceHistory.append(record)
            }
        }
        
        filteredAttendanceHistory.reverse()
        
        historyTableView.reloadData()
        
        // do something with results
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

extension HistoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1000 {
            
            if(isSortedByStudentType)
            {
                
                return allStudents.count + 1
            }
            else{
                
                return allGroups.count + 1
            }
        }else{
            return 0;
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1000{
            
            if(row == 0)
            {
               
                return "None"
            }
            else{
                
                if(isSortedByStudentType)
                {
                    
                    let studentName = allStudents[row - 1].name;
                    
                    return studentName
                }
                else{
                    
                    let groupName = allGroups[row - 1].name;
                    
                    return groupName
                }
            }
            

            
        }
        else {
            return ""
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1000{
            
            if(row == 0)
            {
                sortTextFieldPickerView.text! = ""
                
                if(isSortedByStudentType)
                {
                    
                    selectedStudent = nil
                }
                else{
                    
                    selectedGroup = nil
                }
            }
            else{
                
                if(isSortedByStudentType)
                {
                    
                    sortTextFieldPickerView.text! = allStudents[row - 1].name!
                    
                    selectedStudent = allStudents[row - 1]
                    
                }
                else{
                    
                    sortTextFieldPickerView.text! = allGroups[row - 1].name!
                    
                    selectedGroup = allGroups[row - 1]
                    
                }
            }
            
            
            
        }
        else {
        }

    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredAttendanceHistory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceHistoryCell") as! AttendanceHistoryCell
        
        let attendance = filteredAttendanceHistory[indexPath.row]
        
        cell.studentNameLbl.text! = (attendance.student?.name)!
        
        cell.groupNameLbl.text! = (attendance.group?.name)!
        
        if(attendance.is_paid)
        {
            cell.paidLbl.text! = "Yes"
            
        }
        else{
            
            cell.paidLbl.text! = "No"
            
        }
        
        cell.sessionDateLbl.text! = attendance.attendance_date!
        
        cell.weekDayLbl.text! = attendance.week_day!
        cell.timeFromLbl.text! = attendance.start_time!
        cell.timeToLbl.text! = attendance.end_time!
        
        
        return cell //4.
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let rowFirstAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let alert = UIAlertController(title: "Deleting A History Record", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                
                self.attendanceModelView.deleteAnAttendance(entity: self.filteredAttendanceHistory[indexPath.row])
                
                self.filterTable()
                self.historyTableView.reloadData()
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        })
        
        return [rowFirstAction]
        
    }
    
    
}

