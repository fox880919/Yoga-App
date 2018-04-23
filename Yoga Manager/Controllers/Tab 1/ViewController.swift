//
//  ViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 27/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barAddGroupButton: UIBarButtonItem!
    
    let mainViewModel = MainViewModel()
    
    let studentViewModel = StudentViewModel()
    
    var groups = MainViewModel().getGroups()
    
    let sessionModelView = SessionViewModel()
    
    var currentSelectedGroup : Group!
    
    var lastRowPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = primaryColor
        
        tableView.backgroundColor = lightPrimaryColor
    
        
        // mainViewModel.updateAgroup(oldGroup: groups[0], newName: "Updated")
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        
        lastRowPosition = mainViewModel.getGroups().count + 1
        
        groups = MainViewModel().getGroups()
        
        tableView.reloadData()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
       
        if(mainViewModel.getGroups().count > 0)
        {
            lastRowPosition = mainViewModel.getGroups().count + 1
            
            return mainViewModel.getGroups().count + 2

        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        view.tintColor = lightPrimaryColor
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.section == lastRowPosition)
        {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")!
            
            cell.backgroundColor =  buttonColor

            cell.layer.cornerRadius = 30
            cell.layer.masksToBounds = true
            
           cell.textLabel?.text = "Add a new group"
            
            return cell //4.
        }
        else if(indexPath.section == lastRowPosition - 1)
            {
                let cell = UITableViewCell()
                
                cell.backgroundColor = lightPrimaryColor
                
                return cell
            }
        else{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
                as! GroupTableCell
            
            cell.backgroundColor =  secondaryColor
            
            cell.layer.cornerRadius = 30
            cell.layer.masksToBounds = true
            
            let groups = mainViewModel.getGroups()
            
            let text = groups[indexPath.section].name! //2.
            
            cell.groupNameLabel.text = text //3.
            
            cell.studentsLabel.text = "\(studentViewModel.getGroupStudents(studentsGroup: groups[indexPath.section]).count)"
            
            cell.sessionsLabel.text = "\(groups[indexPath.section].sessions!.count)"
            
            return cell //4.
        }
    }
    
    @IBAction func settingsBtnPressed(_ sender: Any) {
        
        goToSettings()
    }
    
    func goToSettings(){
        
    performSegue(withIdentifier: "goToSettingsSegue", sender: self)

    }
    
    @IBAction func addGroupBtnPressed(_ sender: Any) {
        
        addGroup()
    }
    
    func addGroup()
    {
        performSegue(withIdentifier: "addingGroupSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addingGroupSegue" {
            
            if let destination = segue.destination as? AddingGroupPopupViewController{
                
                destination.title = "Adding New Group"
                
            }
        }
            
        else if segue.identifier == "editGroupSegue" {
            
            if let destination = segue.destination as? AddingGroupPopupViewController{
                
                destination.title = "Edit \(currentSelectedGroup.name!) Group"
                
                destination.selectedGroup = currentSelectedGroup
                
            }
        }
            
            else if segue.identifier == "selectedGroupSegue" {
                
                if let destination = segue.destination as? SelectedGroupViewController{
                    
                    destination.students = currentSelectedGroup.students?.allObjects as! [Student]
                    
                    destination.studentsGroup = currentSelectedGroup
                    
                    destination.allGroupSessions = sessionModelView.getGroupSessions(studentsGroup: currentSelectedGroup)
                }
                    
            }
            
        
        else if segue.identifier == "goToSettingsSegue" {
            
            if let destination = segue.destination as? SettingsViewController{
                
                destination.title = "Settings"
                
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        if(indexPath.section == lastRowPosition)
        {
            addGroup()
        }
        else if(indexPath.section == lastRowPosition - 1)
        {
            
        }
        else{
            
            currentSelectedGroup = mainViewModel.getGroups()[indexPath.section]
            
            performSegue(withIdentifier: "selectedGroupSegue", sender: self)

        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        if (indexPath.section != lastRowPosition) {
        let deleteGroupAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in

            let alert = UIAlertController(title: "Deleting \(self.mainViewModel.getGroups()[indexPath.section].name!) Group", message: "Deleting this group will delete its attendance history as well?", preferredStyle: UIAlertControllerStyle.alert)
            


            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                
                let group = self.mainViewModel.getGroups()[indexPath.section]
                
                let groupAttendance = AttendanceModelView().getGroupAttendance(studentsGroup: group)
                
                
                for attendance in groupAttendance {
                    
                    AttendanceModelView().deleteAnAttendance(entity: attendance)
                }
                
                self.mainViewModel.deleteAGroup(entity: group)

                self.lastRowPosition = self.mainViewModel.getGroups().count + 1
                
                tableView.reloadData()
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)

            alert.addAction(deleteAction)
            alert.addAction(cancelAction)

            self.present(alert, animated: true)
        
        })
            
            let EditGroupAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                self.currentSelectedGroup = self.mainViewModel.getGroups()[indexPath.section]
                
                self.performSegue(withIdentifier: "editGroupSegue", sender: self)
                

            })

            EditGroupAction.backgroundColor = UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0)
            
        return [deleteGroupAction, EditGroupAction]
        }

        else {

            return []
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }

}

