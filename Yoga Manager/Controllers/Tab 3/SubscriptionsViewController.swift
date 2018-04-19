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
    
    var sessionDatesHelperPicker = UIPickerView()
    
    var allPickerGroups = MainViewModel().getGroups()
    
    var allPickerStudentsForAGroup: [Student]!
    
    var pickerSelectedStudentsGroup: Group!
    
    var pickerSelectedStartDate: Date?
    
    var pickerSelectedEndDate: Date?
    
    var pickerHelperDatesArray: [String]?

    var pickerSelectedStudent: Student!
    
    var newInputView : UIView!
    
    var subscriptions = StudentSubscriptionViewModel().getSubscriptions()
    
    var selectedSubscription: StudentSubscription?
    
    let groups = MainViewModel().getGroups()
    
    var isPickersViewOn = false
    
    var scrollView: UIScrollView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Subscriptions"
        

        let addSubscription = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSubscriptionBtnPressed))
        
        self.navigationItem.rightBarButtonItem = addSubscription
        
        subscriptionTableView.dataSource = self
        subscriptionTableView.delegate = self
        
        scrollView = UIScrollView(frame: view.bounds)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addSubscriptionBtnPressed(){
        
        prepareAndShowPickers()
        
        
    }
    
    
    func prepareAndShowPickers(){
    
        if(isPickersViewOn == true)
        {
        }
        else{
            
            isPickersViewOn = true
            
            newInputView = UIView(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: 700))
            
            let groupLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 20))
            groupLabel.textAlignment = .center
            groupLabel.text = "Groups"
            
            GroupsBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 60))
            
            GroupsBtnPicker.delegate = self
            GroupsBtnPicker.dataSource = self
            
            GroupsBtnPicker.backgroundColor = UIColor.white
            
            GroupsBtnPicker.showsSelectionIndicator = true
            
            GroupsBtnPicker.tag = 10;
            
            let sessionsLabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.view.frame.size.width, height: 20))
            sessionsLabel.textAlignment = .center
            sessionsLabel.text = "Selected Group Students"
            
            GroupStudentsBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 190, width: self.view.frame.size.width, height: 60))
        
            GroupStudentsBtnPicker.delegate = self
            GroupStudentsBtnPicker.dataSource = self
            
            GroupStudentsBtnPicker.backgroundColor = UIColor.white
            
            GroupStudentsBtnPicker.showsSelectionIndicator = true
            
            GroupStudentsBtnPicker.tag = 20;
            
            let startDateLbl = UILabel(frame: CGRect(x: 10, y: 270, width: self.view.frame.size.width, height: 20))

            startDateLbl.textAlignment = .center
            
            startDateLbl.text = "From Date:"
            
            startDatePicker = UIDatePicker(frame:CGRect(x: 10, y: 300, width: self.view.frame.size.width - 20, height: 50))
            
            startDatePicker.tag = 30
            
            startDatePicker.datePickerMode = UIDatePickerMode.date

            let endDateLbl = UILabel(frame: CGRect(x: 10, y: 370, width: self.view.frame.size.width, height: 20))
            endDateLbl.textAlignment = .center
            endDateLbl.text = "To Date:"
        
            endDatePicker = UIDatePicker(frame:CGRect(x: 10, y: 400, width: self.view.frame.size.width  - 20, height: 50))

            endDatePicker.tag = 40
        
            endDatePicker.datePickerMode = UIDatePickerMode.date
            
            let helperLbl = UILabel(frame: CGRect(x: 10, y: 460, width: self.view.frame.size.width, height: 20))
            helperLbl.textAlignment = .center
            helperLbl.text = "Note: Group Sessions Dates"
            
            sessionDatesHelperPicker = UIPickerView(frame:CGRect(x: 10, y: 490, width: self.view.frame.size.width  - 20, height: 50))
            
            sessionDatesHelperPicker.tag = 50
            
            sessionDatesHelperPicker.delegate = self
            
            sessionDatesHelperPicker.dataSource = self
            
            sessionDatesHelperPicker.backgroundColor = UIColor.white
            
            sessionDatesHelperPicker.showsSelectionIndicator = true
            
            
            //        let startDateStackView   = UIStackView(frame: CGRect(x: 10, y: 360,width: self.view.frame.size.width, height: 60))
            //        startDateStackView.axis  = UILayoutConstraintAxis.horizontal
            //        startDateStackView.distribution  = UIStackViewDistribution.fill
            //        startDateStackView.alignment = UIStackViewAlignment.center
            //        startDateStackView.spacing   = 16.0
            //
            //        startDateStackView.addArrangedSubview(startDateLbl)
            //        startDateStackView.addArrangedSubview(startDatePicker)
            
//        let endDateStackView   = UIStackView(frame: CGRect(x: 10, y: 440, width: self.view.frame.size.width - 10, height: 60))
//        endDateStackView.axis  = UILayoutConstraintAxis.horizontal
//        endDateStackView.distribution  = UIStackViewDistribution.fillProportionally
//        endDateStackView.alignment = UIStackViewAlignment.center
        
//        endDateStackView.spacing   = 16.0
//
//
//        endDateStackView.addArrangedSubview(endDateLbl)
//        endDateStackView.addArrangedSubview(endDatePicker)

            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneAdding))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelView))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            
            toolBar.isUserInteractionEnabled = true
            
            newInputView.addSubview(toolBar)
            
            newInputView.addSubview(GroupsBtnPicker)
            
            newInputView.addSubview(GroupStudentsBtnPicker)
            
            newInputView.addSubview(groupLabel)
            
            newInputView.addSubview(sessionsLabel)
            
            newInputView.addSubview(startDateLbl)
            
            newInputView.addSubview(startDatePicker)

            newInputView.addSubview(endDateLbl)

            newInputView.addSubview(endDatePicker)
            
            newInputView.addSubview(helperLbl)
            
            newInputView.addSubview(sessionDatesHelperPicker)
        
            newInputView.backgroundColor = UIColor.cyan
            
            newInputView.isUserInteractionEnabled = true
            
            scrollView.contentSize = newInputView.bounds.size
            
            scrollView.addSubview(newInputView)

            self.view.addSubview(scrollView)
        
        }
    
    }
    
    func editASubscription(){
    
        if(isPickersViewOn == true)
        {
        }
        else{
            newInputView = UIView(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: self.view.frame.size.height - 10))
            
            
            let startDateLbl = UILabel(frame: CGRect(x: 10, y: 170, width: self.view.frame.size.width, height: 20))
            
            startDateLbl.textAlignment = .center
            
            startDateLbl.text = "From Date:"
            
            startDatePicker = UIDatePicker(frame:CGRect(x: 10, y: 200, width: self.view.frame.size.width - 20, height: 50))
            
            startDatePicker.tag = 30
            
            startDatePicker.datePickerMode = UIDatePickerMode.date
            
            startDatePicker.date = DateFromString(dateString: (selectedSubscription?.start_date!)!)
            
            let endDateLbl = UILabel(frame: CGRect(x: 10, y: 270, width: self.view.frame.size.width, height: 20))
            endDateLbl.textAlignment = .center
            endDateLbl.text = "To Date:"
            
            endDatePicker = UIDatePicker(frame:CGRect(x: 10, y: 300, width: self.view.frame.size.width  - 20, height: 50))
            
            endDatePicker.tag = 40
            
            endDatePicker.datePickerMode = UIDatePickerMode.date
            
            endDatePicker.date = DateFromString(dateString: (selectedSubscription?.end_date!)!)

            let helperLbl = UILabel(frame: CGRect(x: 10, y: 360, width: self.view.frame.size.width, height: 20))
            helperLbl.textAlignment = .center
            helperLbl.text = "Note: Group Sessions Dates"
            
            sessionDatesHelperPicker = UIPickerView(frame:CGRect(x: 10, y: 390, width: self.view.frame.size.width  - 20, height: 50))
            
            sessionDatesHelperPicker.tag = 50
            
            sessionDatesHelperPicker.delegate = self
            
            sessionDatesHelperPicker.dataSource = self
            
            sessionDatesHelperPicker.backgroundColor = UIColor.white
            
            sessionDatesHelperPicker.showsSelectionIndicator = true
            
            
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneEditting))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelView))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            
            toolBar.isUserInteractionEnabled = true
            
            
            newInputView.addSubview(toolBar)
            
            newInputView.addSubview(startDateLbl)
            
            newInputView.addSubview(startDatePicker)
            
            newInputView.addSubview(endDateLbl)
            
            newInputView.addSubview(endDatePicker)
            
            newInputView.addSubview(helperLbl)
            
            newInputView.addSubview(sessionDatesHelperPicker)
            
            newInputView.backgroundColor = UIColor.cyan
            
            self.view.addSubview(newInputView)
            
        }
    }
    
    func showAlert(message: String!){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    @objc func doneAdding(){
        
        if(pickerSelectedStudentsGroup == nil)
        {
            showAlert(message: "No group was selected")
        }
        
        else if(pickerSelectedStudent == nil){
            
            showAlert(message: "No student was selected")

        }
        
        else{
            
            pickerSelectedStartDate = startDatePicker.date
            
            pickerSelectedEndDate = endDatePicker.date
            
            StudentSubscriptionViewModel().addANewSubscription(startDate: pickerSelectedStartDate!, endDate: pickerSelectedEndDate!, student: pickerSelectedStudent, group: pickerSelectedStudentsGroup)
            
            subscriptions = StudentSubscriptionViewModel().getSubscriptions()

            subscriptions.reverse()
            
            subscriptionTableView.reloadData()
            
            scrollView.removeFromSuperview()
            
            newInputView.removeFromSuperview()

        }
        
        cancelView()
    }
    
    @objc func doneEditting(){
        
        if(selectedSubscription != nil){
            
            pickerSelectedStartDate = startDatePicker.date
            
            pickerSelectedEndDate = endDatePicker.date
            
            StudentSubscriptionViewModel().updateASubscrtiption(subscription: selectedSubscription!, startDate: pickerSelectedStartDate!, endDate: pickerSelectedEndDate!)
            
            subscriptions = StudentSubscriptionViewModel().getSubscriptions()
            
            subscriptions.reverse()
            
            subscriptionTableView.reloadData()
            
            newInputView.removeFromSuperview()

        }
        
        cancelView()
    }
    
    @objc func cancelView(){
        
        isPickersViewOn = false
        
        selectedSubscription = nil
        
        GroupsBtnPicker.resignFirstResponder()
        
        GroupStudentsBtnPicker.resignFirstResponder()
        
        startDatePicker.resignFirstResponder()
        
        endDatePicker.resignFirstResponder()
        
        scrollView.removeFromSuperview()

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
        else if pickerView.tag == 50 {
            
            if let helperCount = pickerHelperDatesArray?.count {
                
                pickerView.backgroundColor = UIColor.white

                return helperCount
            }
            
            else{
                
                pickerView.backgroundColor = UIColor.darkGray
                
                return 0
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
        else if pickerView.tag == 50{
            
            let date = DateFromString(dateString: (pickerHelperDatesArray?[row])!)
            
            return "\(date.dayOfTheWeek()!) \((pickerHelperDatesArray?[row])!)"
        }
        else {
            
            return ""
        }
        
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 10{
            
            if(row == 0)
            {
                //    savedSessionBtnPicker.isHidden = true
                
                allPickerStudentsForAGroup = nil
                
                pickerHelperDatesArray = nil
                
                sessionDatesHelperPicker.reloadAllComponents()
                
                GroupStudentsBtnPicker.reloadAllComponents()
                
                pickerSelectedStudentsGroup = nil
            }
            else{
                
                pickerSelectedStudent = nil
                //savedSessionBtnPicker.isHidden = false
                
                pickerSelectedStudentsGroup = allPickerGroups[row - 1]
                
                pickerHelperDatesArray = getDatesArrayforGroupSessions(group: pickerSelectedStudentsGroup)
                
                sessionDatesHelperPicker.reloadAllComponents()

                allPickerStudentsForAGroup = StudentViewModel().getGroupStudents(studentsGroup: allPickerGroups[row - 1])
                
                GroupStudentsBtnPicker.reloadAllComponents()
                
                GroupStudentsBtnPicker.selectRow(0, inComponent: 0, animated: false)
                
                
            }
            
        }
        else if pickerView.tag == 20{
            
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return groups[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return groups.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let groupSubscriptions = StudentSubscriptionViewModel().getGroupSubscriptions(studentsGroup: groups[section])
        
        return groupSubscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupSubscriptions = StudentSubscriptionViewModel().getGroupSubscriptions(studentsGroup: groups[indexPath.section])
        
        let studentSubscription = groupSubscriptions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subscriptionCell", for: indexPath)
            as! SubscriptionCell
        
        
        cell.costLbl.text! = "\((studentSubscription.group?.subscription_price)!)"

        cell.studentNameLbl.text! = (studentSubscription.student?.name)!

        cell.startDateLbl.text! = studentSubscription.start_date!
        
        cell.endDateLbl.text! = studentSubscription.end_date!

       return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteSubscriptionAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let alert = UIAlertController(title: "Deleting A Subscription", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                
                StudentSubscriptionViewModel().deleteASubscription(entity: self.subscriptions[indexPath.row])
                
                self.subscriptions =  StudentSubscriptionViewModel().getSubscriptions()
                
                self.subscriptions.reverse()
                
                tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        })
        
        let EditSubscriptionAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            self.selectedSubscription = self.subscriptions[indexPath.row]
            
            self.editASubscription()
            
        })
        
        return [deleteSubscriptionAction, EditSubscriptionAction]
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 20)!
        
        header.textLabel?.textAlignment = .center
        
        header.backgroundView?.backgroundColor = getCustomizedMagneta()
    }
    
    
    
}
