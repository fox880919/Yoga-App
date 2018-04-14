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
        
    var selectedSession : Session!
    
    var newSession : Session!
    
    var selectedGroup : Group!
    
    var selectedDay = "Sunday"
    
    var allSessions: [Session]!
    
    var rotationAngle : CGFloat!
    
    var oldLocation : Location!

    let sessionViewModel = SessionViewModel()
    
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
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            
            if let session = newSession {
                
                if selectedSession != nil
                {
                    sessionViewModel.deleteASession(entity: session)

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
    
            oldLocation = session.location
            
            weekDayPickerView.selectRow(getDayComponent(dayName: session.week_day!), inComponent: 0, animated: true)
            
            selectedDay = session.week_day!
            
            if(session.is_weekly == true)
            {
                recurrenceSegment.selectedSegmentIndex = 0
                
            }
            else{
                
                recurrenceSegment.selectedSegmentIndex = 1

            }
            
            startTimePicker.date = dateFromString(dateString: session.start_time!)
            endDatePicker.date = dateFromString(dateString: session.end_time!)
            
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
        if(newSession != nil)
        {
            sessionViewModel.deleteASession(entity: (newSession))
        }
        
        saveSession()
        
        sessionViewModel.saveData()
        
        navigationController?.popViewController(animated: true)
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
            
            oldLocation = session.location
        }
            
        else {
            
            newSession = sessionViewModel.addANewSession(cost: Int(costTextField.text!)!, day: selectedDay, startTime:  startTimePicker.date, endTime: endDatePicker.date, createdDate: Date(), isWeekly: isWeekly, sessionGroup: selectedGroup)
            
        }
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
