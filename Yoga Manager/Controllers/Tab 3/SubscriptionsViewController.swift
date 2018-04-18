//
//  SubscriptionsViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 16/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class SubscriptionsViewController: UIViewController {

    @IBOutlet weak var subscriptionTableView: UITableView!
    
    var GroupsBtnPicker = UIPickerView()
    
    var GroupStudentsBtnPicker = UIPickerView()
    
    var startDatePicker = UIDatePicker()
    
    var endDatePicker = UIDatePicker()
    
    var allPickerGroups = MainViewModel().getGroups()
    
    var allPickerStudentsForAGroup: [Student]!
    
    var pickerSelectedSessionsGroup: Group!
    
    var pickerSelectedStudent: Student!
    
    var newInputView : UIView!
    
    let subscriptions = StudentSubscriptionVIewModel().getSubscriptions()
    
    let groups = MainViewModel().getGroups()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Subscriptions"
        
        newInputView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 360))

        let addSubscription = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSubscriptionBtnPressed))
        
        self.navigationItem.rightBarButtonItem = addSubscription
        
        subscriptionTableView.dataSource = self
        subscriptionTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addSubscriptionBtnPressed(){
        
        GroupsBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 100))
        
        let groupLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 20))
        groupLabel.textAlignment = .center
        groupLabel.text = "Groups"
        
        GroupsBtnPicker.delegate = self
        GroupsBtnPicker.dataSource = self
        
        GroupsBtnPicker.backgroundColor = UIColor.white
        
        GroupsBtnPicker.showsSelectionIndicator = true
        
        GroupsBtnPicker.tag = 10;
        
        GroupStudentsBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 240, width: self.view.frame.size.width, height: 100))
        
        let sessionsLabel = UILabel(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 20))
        sessionsLabel.textAlignment = .center
        sessionsLabel.text = "Selected Group Students"
        
        GroupStudentsBtnPicker.delegate = self
        GroupStudentsBtnPicker.dataSource = self
        
        GroupStudentsBtnPicker.backgroundColor = UIColor.white
        
        GroupStudentsBtnPicker.showsSelectionIndicator = true
        
        GroupStudentsBtnPicker.tag = 20;

        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        newInputView.addSubview(toolBar)
        
        newInputView.addSubview(GroupsBtnPicker)
        
        newInputView.addSubview(GroupStudentsBtnPicker)
        
        newInputView.addSubview(groupLabel)
        
        newInputView.addSubview(sessionsLabel)
        
        newInputView.backgroundColor = UIColor.cyan
        
        self.view.addSubview(newInputView)
        
    }
    
    func showAlert(message: String!){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    @objc func donePicker(){
        
        if(pickerSelectedStudent != nil)
        {
            addAndSaveStudent()
        }
        GroupsBtnPicker.resignFirstResponder()
        
        newInputView.removeFromSuperview()
    }
    
    @objc func cancelPicker(){
        
        GroupsBtnPicker.resignFirstResponder()
        
        newInputView.removeFromSuperview()
    }
    
    func addAndSaveStudent(){


//        subscriptions.add
//            .addToSessions(pickerSelectedSession)
//            
//            sessionViewModel.saveData()
//            
//            allGroupSessions = sessionViewModel.getGroupSessions(studentsGroup: studentsGroup)
//            
//            self.sessionsTableView.reloadData()
            
        
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

extension SubscriptionsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 10 {
            
            return allPickerGroups.count + 1
        }
            
        else  if pickerView.tag == 20 {
            
            if(allPickerStudentsForAGroup != nil )
            {
                pickerView.backgroundColor = UIColor.white
                
                return allPickerStudentsForAGroup.count + 1
                
            }
        }
        
        pickerView.backgroundColor = UIColor.darkGray
        
        return 0;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView.tag == 10{
            
            if(row == 0)
            {
                
                return "None"
            }
            else{
                
                return allPickerGroups[row - 1].name!
            }
        }
            
        else if pickerView.tag == 20{
            
            if(row == 0)
            {
                
                return "None"
            }
            else{
                
                let student = allPickerStudentsForAGroup[row - 1]
                
                return "\(student.name!)"
            }
        }
        else{
            
            return ""
        }
        
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 10{
            
            if(row == 0)
            {
                //    savedSessionBtnPicker.isHidden = true
                
                allPickerStudentsForAGroup = nil
                
                GroupStudentsBtnPicker.reloadAllComponents()
            }
            else{
                
                pickerSelectedStudent = nil
                //savedSessionBtnPicker.isHidden = false
                
                allPickerStudentsForAGroup = StudentViewModel().getGroupStudents(studentsGroup: allPickerGroups[row - 1])
                
                GroupStudentsBtnPicker.reloadAllComponents()
                
                GroupStudentsBtnPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
            
        }
        else    if pickerView.tag == 20{
            
            if(row == 0)
            {
                pickerSelectedStudent = nil
            }
            else{
                
                pickerSelectedStudent = allPickerStudentsForAGroup[row - 1]
            }
        }
        
    }
}

extension SubscriptionsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return groups.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let groupSubscriptions = StudentSubscriptionVIewModel().getGroupSubscriptions(studentsGroup: groups[section])
        
        return groupSubscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupSubscriptions = StudentSubscriptionVIewModel().getGroupSubscriptions(studentsGroup: groups[indexPath.section])
        
        let studentSubscription = groupSubscriptions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subscriptionCell", for: indexPath)
            as! SubscriptionCell
        
        
        cell.groupNameLbl.text! = (studentSubscription.group?.name)!

        cell.studentNameLbl.text! = (studentSubscription.student?.name)!

        cell.startDateLbl.text! = studentSubscription.start_date!
        
        cell.endDateLbl.text! = studentSubscription.end_date!


        
       return cell
    }
    
    
}
