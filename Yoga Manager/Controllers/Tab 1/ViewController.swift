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
        
    
        
        // mainViewModel.updateAgroup(oldGroup: groups[0], newName: "Updated")
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        
        lastRowPosition = mainViewModel.getGroups().count
        
        groups = MainViewModel().getGroups()
        
        tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(mainViewModel.getGroups().count > 0)
        {
            lastRowPosition = mainViewModel.getGroups().count
        }
    
        return mainViewModel.getGroups().count + 1
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        if(indexPath.row == lastRowPosition)
        {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")!
            
           cell.textLabel?.text = "Add a new group"
            
            return cell //4.

        }
        
        else{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")  as! GroupTableCell
            
            let groups = mainViewModel.getGroups()
            
            // let row = indexPath.row
        
            let text = groups[indexPath.row].name! //2.
            
            cell.groupNameLabel.text = text //3.
            
            cell.studentsLabel.text = "\(studentViewModel.getGroupStudents(studentsGroup: groups[indexPath.row]).count)"
            
            cell.sessionsLabel.text = "\(groups[indexPath.row].sessions!.count)"
            
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

        if(indexPath.row == lastRowPosition)
        {
            addGroup()
        }
        
        else{
            
            currentSelectedGroup = mainViewModel.getGroups()[indexPath.row]
            
            performSegue(withIdentifier: "selectedGroupSegue", sender: self)

        }
        
    }
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//
//            if (indexPath.row != lastRowPosition) {
//
//
//                let shareMenu = UIAlertController(title: "Deleting \(self.mainViewModel.getGroups()[indexPath.row].name!) Group", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
//
//                let twitterAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
//                    print("testing deletion")
//                })
//                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
//
//                shareMenu.addAction(twitterAction)
//                shareMenu.addAction(cancelAction)
//
//                self.present(shareMenu, animated: true)
//
//
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        if (indexPath.row != lastRowPosition) {
        let deleteGroupAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in

            let alert = UIAlertController(title: "Deleting \(self.mainViewModel.getGroups()[indexPath.row].name!) Group", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
            


            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                
                self.mainViewModel.deleteAGroup(entity: self.mainViewModel.getGroups()[indexPath.row])
                
                self.lastRowPosition = self.mainViewModel.getGroups().count
                
                tableView.reloadData()
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)

            alert.addAction(deleteAction)
            alert.addAction(cancelAction)

            self.present(alert, animated: true)
        })
            
            let EditGroupAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                self.currentSelectedGroup = self.mainViewModel.getGroups()[indexPath.row]
                
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

