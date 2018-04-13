//
//  HistoryViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 13/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit
import DropDown

class HistoryViewController: UIViewController {
    
    let groups = MainViewModel().getGroups()
    
    let attendanceHistory = AttendanceModelView().getAllAttendance()
    
    var groupAttendanceHistory: [Attendance]!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var selectedAttendance: [Attendance]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterBygGroup(specificGroup: Group) {
        
        groupAttendanceHistory = [Attendance]()
        
        for record in attendanceHistory {
            
            if record.group == specificGroup
            {
                groupAttendanceHistory.append(record)
            }
        }
        
        
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

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return attendanceHistory.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceHistoryCell") as! AttendanceHistoryCell
        
        cell.ceceee
        return cell //4.
        
    }
    
}

