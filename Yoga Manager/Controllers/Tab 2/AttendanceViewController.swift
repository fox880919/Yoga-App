//
//  AttendanceViewController.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/12/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController{

    @IBOutlet weak var attendanceTableView: UITableView!
    
    let groupViewModel = MainViewModel()
    
    let sessionViewModel = SessionViewModel()
    
    let studentViewModel = StudentViewModel()
    
    var selectedGroupStudents: [Student]!
    
    var selectedGroup: Group!
    
    var selectedSession: Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attendanceTableView.delegate = self
        attendanceTableView.dataSource = self

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

}

extension AttendanceViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return groupViewModel.getGroups().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (groupViewModel.getGroups()[section].sessions?.count)!
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
            return groupViewModel.getGroups()[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell1") as! SessionCell
        
        let sectionGroup = groupViewModel.getGroups()[indexPath.section]
        
        let allSessions = sessionViewModel.getGroupSessions(studentsGroup: sectionGroup)
        
        let session = allSessions[indexPath.row]
        
        cell.sessionDayLabel.text! = session.week_day!
        
        cell.sessionStartTimeLabel.text! = "\(session.start_time!)"
        
        cell.sessionsEndTimeLabel.text! = "\(session.end_time!)"
        
        return cell //4.
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        tableView.deselectRow(at: indexPath, animated: true)

         selectedGroup = groupViewModel.getGroups()[indexPath.section]
        
        selectedSession = sessionViewModel.getGroupSessions(studentsGroup: selectedGroup)[indexPath.row]
        
         selectedGroupStudents = studentViewModel.getGroupStudents(studentsGroup: selectedGroup)
        
        performSegue(withIdentifier: "goToStudentCheckListSegue", sender: self)

        
//
//        selectedLocation = allLocations[indexPath.row]
//        
//        performSegue(withIdentifier: "goToLocationSegue", sender: self)
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150;//Choose your custom row height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToStudentCheckListSegue" {

            if let destination = segue.destination as? AttendanceStudentsViewController{

                destination.selectedGroupStudents = selectedGroupStudents
                
                destination.selectedSession = selectedSession
                
                destination.selectedGroup = selectedGroup
                
            }
        }
    }
        
}
