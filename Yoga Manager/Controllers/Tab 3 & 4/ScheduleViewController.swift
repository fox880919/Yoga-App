//
//  ScheduleViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 20/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit
import SpreadsheetView

class ScheduleViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {

    @IBOutlet weak var scheduleView: SpreadsheetView!
    
    var dates = ["7/10/2017", "7/11/2017", "7/12/2017", "7/13/2017", "7/14/2017", "7/15/2017", "7/16/2017"]
    let days = [ "SUNDAY", "MONDAY", "TUESDAY", "WEDNSDAY", "THURSDAY", "FRIDAY", "SATURDAY"]
    let dayColors = [UIColor(red: 0.918, green: 0.224, blue: 0.153, alpha: 1),
                     UIColor(red: 0.106, green: 0.541, blue: 0.827, alpha: 1),
                     UIColor(red: 0.200, green: 0.620, blue: 0.565, alpha: 1),
                     UIColor(red: 0.953, green: 0.498, blue: 0.098, alpha: 1),
                     UIColor(red: 0.400, green: 0.584, blue: 0.141, alpha: 1),
                     UIColor(red: 0.835, green: 0.655, blue: 0.051, alpha: 1),
                     UIColor(red: 0.153, green: 0.569, blue: 0.835, alpha: 1)]
    
//    let hours = ["6:00 AM", "6:15 AM", "6:30 AM", "6:45 AM", "7:00 AM", "7:15 AM", "7:30 AM", "7:45 AM", "8:00 AM", "8:15 AM", "8:30 AM", "8:45 AM", "9:00 AM", "9:15 AM", "9:30 AM", "9:45 AM", "10:00 AM", "10:15 AM", "10:30 AM", "10:45 AM", "11:00 AM", "11:15 AM", "11:30 AM", "11:45 AM", "12:00 AM", "12:15 AM", "12:30 PM", "12:45 AM", "1:00 PM", "1:15 PM", "1:30 PM", "1:45 PM", "2:00 PM",
//                 "2:15 PM", "2:30 PM", "2:45 AM", "3:00 PM", "3:15 PM", "3:30 PM", "3:45 PM", "4:00 PM", "4:15 PM", "4:30 PM", "4:45 PM", "5:00 PM", "5:15 PM", "5:30 PM", "5:45 PM", "6:00 PM", "6:15 PM", "6:30 PM", "6:45 PM", "7:00 PM", "7:15 PM", "7:30 PM", "7:45 PM", "8:00 PM", "8:15 PM", "8:30 PM", "8:45 PM", "9:00 PM", "9:15 PM", "9:30 PM", "9:45 AM", "10:00 PM", "10:15 PM", "10:30 PM", "10:45 PM", "11:00 PM"]
    
    let hours = ["6:00 AM", "", "", "", "7:00 AM", "", "", "", "8:00 AM", "", "", "", "9:00 AM", "", "", "", "10:00 AM", "", "", "", "11:00 AM", "", "", "", "12:00 AM", "", "", "","1:00 PM", "", "", "", "2:00 PM", "", "", "", "3:00 PM", "", "", "", "4:00 PM", "", "", "", "5:00 PM", "", "", "", "6:00 PM", "", "", "", "7:00 PM", "", "", "", "8:00 PM", "", "", "","9:00 PM", "", "", "","10:00 PM", "10:15 PM", "", "", "", "11:00 PM"]
    let evenRowColor = UIColor(red: 0.914, green: 0.914, blue: 0.906, alpha: 1)
    let oddRowColor: UIColor = .white
    var data = [
        ["", "", "Take medicine", "", "", "", "", "", "", "", "", "", "", "Movie with family", "", "", "", "", "", ""],
        ["Leave for cabin", "", "", "", "", "Lunch with Tim", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "Downtown parade", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "Fireworks show", "", "", ""],
        ["", "", "", "", "", "Family BBQ", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", "", "", "", "", "Return home", "", "", "", "", "", ""]
    ]
    
    var sessions = SessionViewModel().getAllSessions()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        dates = getNext30Days()
        scheduleView.dataSource = self
        scheduleView.delegate = self
        
        scheduleView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        
        scheduleView.intercellSpacing = CGSize(width: 4, height: 1)
        scheduleView.gridStyle = .solid(width: 1, color: UIColor.blue)
        
        scheduleView.register(DateCell.self, forCellWithReuseIdentifier: String(describing: DateCell.self))
        scheduleView.register(TimeTitleCell.self, forCellWithReuseIdentifier: String(describing: TimeTitleCell.self))
        scheduleView.register(TimeCell.self, forCellWithReuseIdentifier: String(describing: TimeCell.self))
        scheduleView.register(DayTitleCell.self, forCellWithReuseIdentifier: String(describing: DayTitleCell.self))
        scheduleView.register(ScheduleCell.self, forCellWithReuseIdentifier: String(describing: ScheduleCell.self))
        
        // Do any additional setup after loading the view.
        setValues()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        setValues()
    }
    
    func setValues()
    {
    
        sessions = SessionViewModel().getAllSessions()

        data =  [[String]]()
        
        var sundaySessions = [Session]()
        
        var mondaySessions = [Session]()

        var tuesdaySessions = [Session]()

        var wednesdaySessions = [Session]()

        var thursdaySessions = [Session]()

        var fridaySessions = [Session]()

        var saturdaySessions = [Session]()

        
        for session in sessions {
            
            //let sessionGroupsNames = returnSessionGroupsName(Session: session)
            
        
            if(session.week_day == "Sunday")
            {
                
                sundaySessions.append(session)
            }
            else if(session.week_day == "Monday")
            {
                
                mondaySessions.append(session)
            }
            else if(session.week_day == "Tuesday")
            {
                
                tuesdaySessions.append(session)
            }
            else if(session.week_day == "Wednesday")
            {
             
                wednesdaySessions.append(session)

            }
            else if(session.week_day == "Thursday")
            {
                
                thursdaySessions.append(session)
            }
            else if(session.week_day == "Friday")
            {
             
                fridaySessions.append(session)
            }
            else if(session.week_day == "Saturday")
            {
                
                saturdaySessions.append(session)
            }
        }
        
        let sundaySessionsStrings = organizingSessionsWithinADay(sessions: sundaySessions)
        
        let mondaySessionsStrings = organizingSessionsWithinADay(sessions: mondaySessions)
        
        let tuesdaySessionsStrings = organizingSessionsWithinADay(sessions: tuesdaySessions)
        
        let wednesdaySessionsStrings = organizingSessionsWithinADay(sessions: wednesdaySessions)
        
        let thursdaySessionsStrings = organizingSessionsWithinADay(sessions: thursdaySessions)
        
        let fridaySessionsStrings = organizingSessionsWithinADay(sessions: fridaySessions)
        
        let saturdaySessionsStrings = organizingSessionsWithinADay(sessions: saturdaySessions)
        
        data.append(sundaySessionsStrings)
        data.append(mondaySessionsStrings)
        data.append(tuesdaySessionsStrings)
        data.append(wednesdaySessionsStrings)
        data.append(thursdaySessionsStrings)
        data.append(fridaySessionsStrings)
        data.append(saturdaySessionsStrings)

    }
    
    func returnSessionGroupsName(session: Session) -> String{
    
        var sessionGroupsNames : String?
        
        let sessionGroups = SessionViewModel().getSessionGroups(session: session)
        
        for group in sessionGroups{
            
            if(sessionGroupsNames == nil)
            {
                
                sessionGroupsNames = group.name!
            }
            else{
                
                sessionGroupsNames =  sessionGroupsNames! + " & " + group.name!
            }
        }
        
        return sessionGroupsNames!
    }
    
    func organizingSessionsWithinADay(sessions: [Session]) -> [String]{
        
//        let organizedSessions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
        
        var organizedSessions = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
        
        
        for session in sessions{
            
            
            
            let startIndex = returnIndexOfTimeInTimeTable(timeString: session.start_time!)
            
            let endIndex = returnIndexOfTimeInTimeTable(timeString: session.end_time!)
            
            var difference = endIndex - startIndex
            
            organizedSessions[startIndex] = returnSessionGroupsName(session: session)
            
            var i = 1
            
            let sessionGroupName = returnSessionGroupsName(session: session)
            
            while(difference != 0)
            {

                organizedSessions[startIndex + i] = sessionGroupName
                
                i = i + 1
            
                difference = difference - 1
            }
        }
        
        return organizedSessions
    }
    
    func returnIndexOfTimeInTimeTable(timeString: String) -> Int{
        
        let time = timeFromString(dateString: timeString)
        
        let hour = (Calendar.current.component(.hour, from: time) - 6) * 4
        
        let minutes = Calendar.current.component(.hour, from: time)
        
        var index = hour
        
        if(minutes == 15)
        {
            
        }
        else if(minutes == 30)
        {
            
            index = hour + 2
        }
        else if(minutes == 45)
        {
            
            index = hour + 3
        }

        
        return index
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        
        return 1 + days.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + 1 + hours.count
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return 70
        } else {
            return 120
        }
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 24
        } else if case 1 = row {
            return 32
        } else {
            return 40
        }
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case (1...(dates.count + 1), 0) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: DateCell.self), for: indexPath) as! DateCell
            cell.label.text = dates[indexPath.column - 1]
            return cell
        } else if case (1...(days.count + 1), 1) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: DayTitleCell.self), for: indexPath) as! DayTitleCell
            cell.label.text = days[indexPath.column - 1]
            cell.label.textColor = dayColors[indexPath.column - 1]
            return cell
        } else if case (0, 1) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeTitleCell.self), for: indexPath) as! TimeTitleCell
            cell.label.text = "TIME"
            return cell
        } else if case (0, 2...(hours.count + 2)) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeCell.self), for: indexPath) as! TimeCell
            cell.label.text = hours[indexPath.row - 2]
            cell.backgroundColor = indexPath.row % 2 == 0 ? evenRowColor : oddRowColor
            return cell
        } else if case (1...(days.count + 1), 2...(hours.count + 2)) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ScheduleCell.self), for: indexPath) as! ScheduleCell
            let text = data[indexPath.column - 1][indexPath.row - 2]
            if !text.isEmpty {
                cell.label.text = text
                let color = dayColors[indexPath.column - 1]
                cell.label.textColor = color
                cell.color = color.withAlphaComponent(0.2)
                cell.borders.top = .solid(width: 2, color: color)
                cell.borders.bottom = .solid(width: 2, color: color)
            } else {
                cell.label.text = nil
                cell.color = indexPath.row % 2 == 0 ? evenRowColor : oddRowColor
                cell.borders.top = .none
                cell.borders.bottom = .none
            }
            return cell
        }
        return nil
    }
    
    /// Delegate
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
    }
}
