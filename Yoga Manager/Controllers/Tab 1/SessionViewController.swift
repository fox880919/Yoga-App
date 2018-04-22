//
//  SessionViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 07/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit


class SessionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var weekDayPickerView: UIPickerView!
    
    @IBOutlet weak var recurrenceSegment: UISegmentedControl!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let weekDaysValues = ["Sunday", "Monday", "Tuesday", "Wednesay", "Thursday", "Friday", "Saturday"]
    
    var newCopyOfLocation: Location!
    
    var newCopyOfSession: Session!
    
    var sameCopyOfLocation: Location!
    
    var isSavedButtonPessed = false
    
    var selectedSession : Session!
    
    var newSession : Session!
    
    var selectedGroup : Group!
    
    var selectedDay = "Sunday"
    
    var allSessions: [Session]!
    
    var rotationAngle : CGFloat!
    
    var conflictGroup: Group!
    
    let sessionViewModel = SessionViewModel()
    
    let locationViewModel = LocationModelView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
        
        self.navigationItem.rightBarButtonItem = saveBtn
        
        weekDayPickerView.dataSource = self
        weekDayPickerView.delegate = self
        
        weekDayPickerView.layer.borderColor = UIColor.black.cgColor
        weekDayPickerView.layer.borderWidth = 1.5

        rotationAngle = -90 * (.pi/180)
        weekDayPickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        costTextField.keyboardType = UIKeyboardType.numberPad
  
        
        setSessionValues()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let session = selectedSession {
            
            if let location = session.location?.name {
                
                locationLabel.text! = location

            }
        }
        
        else if let session = newSession {
            
            if let location = session.location?.name {
                
                locationLabel.text! = location
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            
            if isSavedButtonPessed != true
            {
                if selectedSession != nil {
                    
                    sessionViewModel.updateASession(cost: Int(newCopyOfSession.cost), day: newCopyOfSession.week_day!, startTime: timeFromString(dateString: newCopyOfSession.start_time!), endTime: timeFromString(dateString: newCopyOfSession.end_time!), isWeekly: newCopyOfSession.is_weekly, currentSession: selectedSession)
                    
                    sessionViewModel.deleteASession(entity: newCopyOfSession)

                    if(newCopyOfLocation != nil)
                    {
                        selectedSession.location = sameCopyOfLocation
                        
                        locationViewModel.updateALocation(location: selectedSession.location!, name: newCopyOfLocation.name!, latitude: newCopyOfLocation.latitude!, longitude: newCopyOfLocation.longitude!, address: newCopyOfLocation.address!)
                        
                        locationViewModel.deleteALocation(entity: newCopyOfLocation)
                    }
                        
                    else{
                        
                        selectedSession.location = nil
                        
                    }

                }
                else if(newSession != nil)
                {
                
                sessionViewModel.deleteASession(entity: newSession)

                }
            }
            
            else {
                
                if(newCopyOfSession != nil)
                {
                    sessionViewModel.deleteASession(entity: newCopyOfSession)

                }
                
                if(newCopyOfLocation != nil)
                {
                    
                    locationViewModel.deleteALocation(entity: newCopyOfLocation)
                }
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSessionValues(){
        
        if let session = selectedSession {
            
            newCopyOfSession = sessionViewModel.addANewSession(cost: Int(session.cost), day: session.week_day!, startTime: timeFromString(dateString: session.start_time!), endTime: timeFromString(dateString: session.end_time!), createdDate: Date(), isWeekly: session.is_weekly, sessionGroup: selectedGroup)
            
            if let location = selectedSession.location
            {
                
                newCopyOfLocation = locationViewModel.addANewLocation(name: location.name!, latitude: location.latitude!, longitude: location.longitude!, address: location.address!)
                
                sameCopyOfLocation = location
            }
            
            weekDayPickerView.selectRow(getDayComponent(dayName: session.week_day!), inComponent: 0, animated: true)
            
            selectedDay = session.week_day!
            
            if(session.is_weekly == true)
            {
                recurrenceSegment.selectedSegmentIndex = 0
                
            }
            else{
                
                recurrenceSegment.selectedSegmentIndex = 1

            }
            
            startTimePicker.date = timeFromString(dateString: session.start_time!)
            endDatePicker.date = timeFromString(dateString: session.end_time!)
            
            costTextField.text! = "\(session.cost)"
            
            locationLabel.text! = session.location?.name ?? "No location"
            
        }
        else{
            
            costTextField.text! = "\(selectedGroup.session_price)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            
            let startDate = dateFormatter.date(from: "18:00")
            
            let endDate = dateFormatter.date(from: "20:00")

            startTimePicker.date = startDate!
            endDatePicker.date = endDate!
        }
        
    }
    
    @objc func saveBtnPressed()
    {

        if(getHourFromDate(date: startTimePicker.date) < 6)
        {
            
            showAlert(message: "Start-time can't be before 6:00 AM")
            return
        }
        else if((getHourFromDate(date: endDatePicker.date) == 23 && getMinutesFromDate(date: endDatePicker.date) > 0) || getHourFromDate(date: endDatePicker.date) > 23)
        {
            
            showAlert(message: "End-time can't be after 11:00 PM")
            return
        }
        
        else if(getHourFromDate(date: startTimePicker.date) > getHourFromDate(date: endDatePicker.date))
        {
            
            showAlert(message: "Start-time can't be after end-time")
        }
        var isWeekly = true
        
        if (recurrenceSegment.selectedSegmentIndex == 1)
        {
            isWeekly = false
        }
        
        
        if(selectedSession != nil)
        {
            sessionViewModel.updateASession(cost: Int(costTextField.text!)!, day: selectedDay, startTime: startTimePicker.date, endTime: endDatePicker.date, isWeekly: isWeekly, currentSession: selectedSession)
            
            if(checkSessionConflict(testingSession: selectedSession) == true)
            {
                
                showConflictAlert()
                return
            }
                
            else{
                
                safeToSaveSession()
            }
            
        }
        else if(newSession != nil){
        
            sessionViewModel.deleteASession(entity: newSession)

            newSession = sessionViewModel.addANewSession(cost: Int(costTextField.text!)!, day: selectedDay, startTime:  startTimePicker.date, endTime: endDatePicker.date, createdDate: Date(), isWeekly: isWeekly, sessionGroup: selectedGroup)
            
            if(checkSessionConflict(testingSession: newSession) == true)
            {
                
                sessionViewModel.deleteASession(entity: newSession)
                
                newSession = nil
                
                showConflictAlert()
                
                return
            }
            
            else{
                
                safeToSaveSession()
            }
        }
        else{
            
            newSession = sessionViewModel.addANewSession(cost: Int(costTextField.text!)!, day: selectedDay, startTime:  startTimePicker.date, endTime: endDatePicker.date, createdDate: Date(), isWeekly: isWeekly, sessionGroup: selectedGroup)
            
            sessionViewModel.saveData()
            
            if(checkSessionConflict(testingSession: newSession) == true)
            {
                sessionViewModel.deleteASession(entity: newSession)
                
                newSession = nil
                
                showConflictAlert()
                return
            }
                
            else{
                
                safeToSaveSession()
            }
        }
    }

    func safeToSaveSession()
    {
        
        
        isSavedButtonPessed = true
        
        saveSession()
        
        sessionViewModel.saveData()
        
        if selectedSession != nil
        {
            if(newCopyOfLocation != nil)
            {
                
                locationViewModel.deleteALocation(entity: newCopyOfLocation)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }

        
    func showConflictAlert(){
        
        let alert = UIAlertController(title: "Error ", message: "The new session has a conflict with another session in \(conflictGroup.name!)", preferredStyle: UIAlertControllerStyle.alert)
        
//        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
//
//            self.safeToSaveSession()
//
//        })
        
        let noAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { action in
            
        })
        
//        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        
        self.present(alert, animated: true)
    }

    func checkSessionConflict(testingSession: Session) -> Bool
    {
        let groups = MainViewModel().getGroups()
        
        for group in groups {
            
            let sessions = sessionViewModel.getGroupSessions(studentsGroup: group)
            
            var currentSession: Session
            
            if selectedSession != nil {
             
                currentSession = selectedSession
            }
            else{
                
                currentSession = newSession
            }
    
            
            for session in sessions{

                
                if(newCopyOfSession == nil)
                {
                    
                    if(session.week_day! == testingSession.week_day! && session.objectID != currentSession.objectID)
                    {
                        
                        let sessionStartTime = timeFromString(dateString: session.start_time!)
                        
                        let sessionEndTime = timeFromString(dateString: session.end_time!)
                        
                        let addedSessionStartTime = timeFromString(dateString: testingSession.start_time!)
                        
                        let addedSessionEndTime = timeFromString(dateString: testingSession.end_time!)
                        
                        if ( addedSessionStartTime >= sessionStartTime &&  addedSessionStartTime < sessionEndTime)
                        {
                            conflictGroup = group
                            return true
                        }
                        else if ( addedSessionEndTime > sessionStartTime &&  addedSessionEndTime <= sessionEndTime)
                        {
                            conflictGroup = group
                            return true
                        }
                        
                        // Should be redundant
                        //                    else if( addedSessionStartTime >= sessionStartTime  && addedSessionEndTime <= sessionEndTime)
                        //                    {
                        //                        conflictGroup = group
                        //                        return true
                        //                    }
                    }
                }
                else{
                    
                    if(session.week_day! == testingSession.week_day! && session.objectID != currentSession.objectID && session.objectID != newCopyOfSession.objectID )
                    {
                        
                        let sessionStartTime = timeFromString(dateString: session.start_time!)
                        
                        let sessionEndTime = timeFromString(dateString: session.end_time!)
                        
                        let addedSessionStartTime = timeFromString(dateString: testingSession.start_time!)
                        
                        let addedSessionEndTime = timeFromString(dateString: testingSession.end_time!)
                        
                        if ( addedSessionStartTime >= sessionStartTime &&  addedSessionStartTime < sessionEndTime)
                        {
                            conflictGroup = group
                            return true
                        }
                        else if ( addedSessionEndTime > sessionStartTime &&  addedSessionEndTime <= sessionEndTime)
                        {
                            conflictGroup = group
                            return true
                        }
                        
                        // Should be redundant
                        //                    else if( addedSessionStartTime >= sessionStartTime  && addedSessionEndTime <= sessionEndTime)
                        //                    {
                        //                        conflictGroup = group
                        //                        return true
                        //                    }
                    }
                }
            }
        }
        return false
    }
    
    func saveSession()
    {
        
        var isWeekly = true
        if (recurrenceSegment.selectedSegmentIndex == 1)
        {
            isWeekly = false
        }
        
        if let session = selectedSession{
            
            sessionViewModel.updateASession(cost: Int(costTextField.text!)!, day: selectedDay, startTime: startTimePicker.date, endTime: endDatePicker.date, isWeekly: isWeekly, currentSession: session)
                    }
            
        else {
            
            if(newSession == nil)
            {
                
                newSession = sessionViewModel.addANewSession(cost: Int(costTextField.text!)!, day: selectedDay, startTime:  startTimePicker.date, endTime: endDatePicker.date, createdDate: Date(), isWeekly: isWeekly, sessionGroup: selectedGroup)
            }
            else
            {
                
                sessionViewModel.updateASession(cost: Int(costTextField.text!)!, day: selectedDay, startTime:  startTimePicker.date, endTime: endDatePicker.date, isWeekly: isWeekly, currentSession: newSession)
            }
          // newSession.location =
            
        }
    }
    
    func showAlert(message: String!){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        selectedDay = getDayName(componentInt: row)

    }
    

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
      
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.textAlignment = .center
        label.text = weekDaysValues[row]
        
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        return view
        
    }
    
    
    @IBAction func sessionMapBtnPressed(_ sender: Any) {
        
        saveSession()
  
        self.performSegue(withIdentifier: "SessionMapSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SessionMapSegue" {
            

            
            
            if let destination = segue.destination as? SessionMapViewController{
                
                if let session = selectedSession {
                    
                    destination.session = session
                }
                
                else if let session = newSession {
                    
                    destination.session = session
                 
                }
 
            }
            
        }
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
