//
//  SelectedGroupViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 06/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class SelectedGroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var studentsCollectionView: UICollectionView!
    
    @IBOutlet weak var sessionsTableView: UITableView!
    var students : [Student]!
    
    var selectedStudent: Student!
    
    var selectedSession : Session!

     var allGroupSessions: [Session]!
    
    var studentsGroup : Group!
    
    let studentViewModel = StudentViewModel()
    
    let sessionViewModel = SessionViewModel()
    
     var lastRowPosition = 0
    
    var savedGroupsBtnPicker = UIPickerView()

    var savedSessionBtnPicker = UIPickerView()
    
    var allPickerGroups = MainViewModel().getGroups()

    var allPickerSessionsForAGroup: [Session]!
    
    
    var pickerSelectedSessionsGroup: Group!
    
    var pickerSelectedSession: Session!

    var newInputView : UIView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentsCollectionView.dataSource = self
        
       studentsCollectionView.delegate = self
        
        sessionsTableView.dataSource = self
        
        sessionsTableView.delegate = self
        
        newInputView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 360))
        
        allPickerGroups.remove(at: allPickerGroups.index(of: studentsGroup)!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
       self.studentsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "headerID")
        
        let addStudentBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStudent))
        
        self.navigationItem.rightBarButtonItem = addStudentBtn
        
        students = studentViewModel.getGroupStudents(studentsGroup: studentsGroup)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        students = studentViewModel.getGroupStudents(studentsGroup: studentsGroup)
        
        self.studentsCollectionView.reloadData()
        
        allGroupSessions = sessionViewModel.getGroupSessions(studentsGroup: studentsGroup)
        
        self.sessionsTableView.reloadData()
    }
    
    @objc func addStudent ()
    {
        let PhotoAlert = UIAlertController(title: "Student", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        PhotoAlert.addAction(UIAlertAction(title: "New", style: .default, handler: { (action: UIAlertAction!) in
            
            self.performSegue(withIdentifier: "addStudentSegue", sender: self)
            
        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Existing", style: .default, handler: { (action: UIAlertAction!) in
            
            self.performSegue(withIdentifier: "goToAllStudentsSegue", sender: self)
            
        }))
        
        present(PhotoAlert, animated: true, completion: nil)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath)
//        return headerView
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderlabel.text = "Students"
            return sectionHeader
        }
        return UICollectionReusableView()
    }


     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        
        return students.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCell1", for: indexPath)
            as! GroupStudentCell
        
        // Configure the cell
        
        cell.studentNameLabel.text! = students[indexPath.row].name!
        
        if let image = UIImage(data: students[indexPath.row].photo!)
        {
            cell.studentImage.image! = image
        }
        
        return cell
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedStudent = students[indexPath.row]
        
        let PhotoAlert = UIAlertController(title: "Actions for \(selectedStudent.name!)", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        PhotoAlert.addAction(UIAlertAction(title: "edit", style: .default, handler: { (action: UIAlertAction!) in
            
            self.performSegue(withIdentifier: "editStudentSegue", sender: self)
            
        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { (action: UIAlertAction!) in
            
            self.studentViewModel.removeGroup(student: self.selectedStudent, studentGroup: self.studentsGroup)
            
            self.students = self.studentViewModel.getGroupStudents(studentsGroup: self.studentsGroup)
            
            self.studentsCollectionView.reloadData()
            
        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(PhotoAlert, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 10))/2, height: 220)
        
        return cellSize
        
        //return CGSize(width: (collectionView.frame.width/2) - 5, height: collectionView.frame.width/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        return sectionInset
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
        if (section == 0)
        {

            return "Sessions"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        view.tintColor = lightPrimaryColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let sessionCount = sessionViewModel.getGroupSessions(studentsGroup: studentsGroup).count
        
        if(sessionCount > 0)
        {
            lastRowPosition = sessionCount
        }
        
        return sessionCount  + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == lastRowPosition)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "addSessionCell")!
            
            cell.layer.cornerRadius = 30
            cell.layer.masksToBounds = true
            
            cell.backgroundColor = buttonColor
            
            cell.textLabel?.backgroundColor = buttonColor
            
            cell.textLabel?.text = "Add a new session"
            
            return cell //4.
            
        }
        
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionsCell1") as! SessionCell
            
            cell.layer.cornerRadius = 30
            cell.layer.masksToBounds = true
            
            let session = allGroupSessions[indexPath.section]
            
            cell.sessionDayLabel.text! = session.week_day!
            
            cell.sessionStartTimeLabel.text! = "\(session.start_time!)"

            cell.sessionsEndTimeLabel.text! = "\(session.end_time!)"
            
            if(session.is_weekly == false)
            {
                
                let daysCount = countDaysDifference(startDate: session.created_date!, endDate: Date())
                
                if ((Date().dayOfTheWeek() == session.week_day && daysCount > 6) || daysCount > 7)
                {
                
                    cell.backgroundColor = UIColor.lightGray
                }
                else
                {
                    
                    cell.backgroundColor = UIColor.yellow

                }
            }
            else{
                
                cell.backgroundColor = UIColor.white
            }

            return cell //4.
        }
     
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.section == lastRowPosition)
        {
            addSession()
        }
            
        else{
            
            selectedSession = allGroupSessions[indexPath.section]
            
            self.performSegue(withIdentifier: "editSessionSegue", sender: self)
            
        }

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        if (indexPath.section != lastRowPosition) {
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let alert = UIAlertController(title: "Deleting Session number \(indexPath.section + 1)", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
                
                let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                    
                    let sessionToDelete = self.allGroupSessions[indexPath.section]
                    
                    
                    if(sessionToDelete.groups!.count > 1)
                    {
                        self.deletingSessionOptions(sessionToDelete: sessionToDelete)
                    }
                    else{
                        
                        self.sessionViewModel.deleteASession(entity: sessionToDelete)
                        
                        self.allGroupSessions = self.sessionViewModel.getGroupSessions(studentsGroup: self.studentsGroup)
                        
                        self.lastRowPosition = self.allGroupSessions.count
                        
                        tableView.reloadData()
                    }
                    

                    
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
            })
            
            
            
            return [shareAction]
        }
            
        else {
            
            return []
        }
    }
    
    
    func addSession()
    {
        
        let PhotoAlert = UIAlertController(title: "Adding Session", message: "Add a new or an existing session?", preferredStyle: UIAlertControllerStyle.alert)
        
        
        PhotoAlert.addAction(UIAlertAction(title: "New", style: .default, handler: { (action: UIAlertAction!) in
            
            self.performSegue(withIdentifier: "addSessionSegue", sender: self)

        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Existing", style: .default, handler: { (action: UIAlertAction!) in
            
            self.addExistingSession()
            
        }))
        
        present(PhotoAlert, animated: true, completion: nil)
        

    }
    
    func addExistingSession(){
        
        
        savedGroupsBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 100))
        
        let groupLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 20))
        groupLabel.textAlignment = .center
        groupLabel.text = "Groups"
        
        savedGroupsBtnPicker.delegate = self
        savedGroupsBtnPicker.dataSource = self
        
        savedGroupsBtnPicker.backgroundColor = UIColor.white
        
        savedGroupsBtnPicker.showsSelectionIndicator = true
        
        savedGroupsBtnPicker.tag = 10;
        

        
        savedSessionBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 240, width: self.view.frame.size.width, height: 100))
        
        let sessionsLabel = UILabel(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 20))
        sessionsLabel.textAlignment = .center
        sessionsLabel.text = "Selected Group Sessions"
        
        savedSessionBtnPicker.delegate = self
        savedSessionBtnPicker.dataSource = self
        
        savedSessionBtnPicker.backgroundColor = UIColor.white
        
        savedSessionBtnPicker.showsSelectionIndicator = true
        
        savedSessionBtnPicker.tag = 20;
        
        //savedSessionBtnPicker.isHidden = true

        
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

        newInputView.addSubview(savedGroupsBtnPicker)
        
        newInputView.addSubview(savedSessionBtnPicker)
        
        newInputView.addSubview(groupLabel)
        
        newInputView.addSubview(sessionsLabel)
        
        newInputView.backgroundColor = UIColor.cyan
        
        self.view.addSubview(newInputView)
        
    }
    
    @objc func donePicker(){
        
        if(pickerSelectedSession != nil)
        {
            addAndSaveSession()
        }
        savedGroupsBtnPicker.resignFirstResponder()
        
        newInputView.removeFromSuperview()
    }
    
    @objc func cancelPicker(){
        
        savedGroupsBtnPicker.resignFirstResponder()
        
        newInputView.removeFromSuperview()
    }
    
    func addAndSaveSession(){
        
        if(studentsGroup.sessions?.contains(pickerSelectedSession))!
        {
            showAlert(message: "This session exist in this group")
        }
        else
        {
            if(checkSessionConflict() == false){

                studentsGroup.addToSessions(pickerSelectedSession)
                
                sessionViewModel.saveData()
                
                allGroupSessions = sessionViewModel.getGroupSessions(studentsGroup: studentsGroup)
                
                self.sessionsTableView.reloadData()

                
            }
            else{
                
                showConflictAlert()
            }
        }
    }
    
    func showAlert(message: String!){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                        })
        
                        alert.addAction(okAction)
        
                        self.present(alert, animated: true)
    }
    
    func showConflictAlert(){
    
        let alert = UIAlertController(title: "Warning ", message: "The new session has a conflict with another session in this group, \(studentsGroup.name!), do you want to continue adding the session?", preferredStyle: UIAlertControllerStyle.alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
        
            self.studentsGroup.addToSessions(self.pickerSelectedSession)
            
            self.sessionViewModel.saveData()
            
            self.allGroupSessions = self.sessionViewModel.getGroupSessions(studentsGroup: self.studentsGroup)
            
            self.sessionsTableView.reloadData()
            
        })
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { action in
            print("testing deletion")
            
            self.pickerSelectedSession = nil
        })
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        
        self.present(alert, animated: true)
    }
    
    func checkSessionConflict() -> Bool
    {
        let sessions = sessionViewModel.getGroupSessions(studentsGroup: studentsGroup)
        
        for session in sessions{
            
            if(session.week_day! == pickerSelectedSession.week_day!)
            {

                let sessionStartTime = timeFromString(dateString: session.start_time!)
                
                let sessionEndTime = timeFromString(dateString: session.end_time!)
                
                let addedSessionStartTime = timeFromString(dateString: pickerSelectedSession.start_time!)
                
                let addedsessionEndTime = timeFromString(dateString: pickerSelectedSession.end_time!)
                
                if ( addedSessionStartTime >= sessionStartTime &&  addedSessionStartTime <= sessionEndTime)
                {
                    
                    return true
                }
                else if ( addedsessionEndTime >= sessionStartTime &&  addedsessionEndTime <= sessionEndTime)
                {
                    
                    return true
                }
            }

        }
        
        return false
    }
    
    func deletingSessionOptions(sessionToDelete: Session!)
    {

        let deletingOptionsAlert = UIAlertController(title: "Options for deleting", message: " This session exists in another group !!", preferredStyle: UIAlertControllerStyle.alert)
        
        
        deletingOptionsAlert.addAction(UIAlertAction(title: "Remove from this group Only", style: .default, handler: { (action: UIAlertAction!) in
            
            self.studentsGroup.removeFromSessions(sessionToDelete)

            self.allGroupSessions = self.sessionViewModel.getGroupSessions(studentsGroup: self.studentsGroup)
            
            self.lastRowPosition = self.allGroupSessions.count
            
            self.sessionsTableView.reloadData()
        }))
        
        deletingOptionsAlert.addAction(UIAlertAction(title: "Delete from here and all groups", style: .destructive, handler: { (action: UIAlertAction!) in
            
            self.sessionViewModel.deleteASession(entity: sessionToDelete)

            self.allGroupSessions = self.sessionViewModel.getGroupSessions(studentsGroup: self.studentsGroup)
            
            self.lastRowPosition = self.allGroupSessions.count
            
            self.sessionsTableView.reloadData()
            
        }))
        
        deletingOptionsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(deletingOptionsAlert, animated: true, completion: nil)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addStudentSegue" {
            
            if let destination = segue.destination as? StudentViewController{
                
                destination.title = "New Student"
                destination.studentGroup = studentsGroup
                
            }
        }
        
        if segue.identifier == "editStudentSegue" {
            
            if let destination = segue.destination as? StudentViewController{
                
                destination.title = "\(selectedStudent.name!) Profile"
                
                destination.oldStudent = selectedStudent
                
            }
        }
            
            
        else if segue.identifier == "addSessionSegue"{
            
            if let destination = segue.destination as? SessionViewController{
                
                destination.title = "New Session"
                destination.selectedGroup = studentsGroup
                
            }
            
        }
            
        else if segue.identifier == "editSessionSegue" {
            
            if let destination = segue.destination as? SessionViewController{
                
                destination.title = "Edit Session"
                destination.selectedSession = selectedSession
                destination.selectedGroup = studentsGroup

                
            }
        }
            
            else if segue.identifier == "goToAllStudentsSegue" {
                
                if let destination = segue.destination as? AllStudentsViewController{
                    
                    destination.title = "All Students"
                    destination.registeredStudents = students
                    destination.studentsGroup = studentsGroup
                }
            }
        
    }
}
    
extension SelectedGroupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 10 {
            
                return allPickerGroups.count + 1
        }

            else  if pickerView.tag == 20 {
            
            if(allPickerSessionsForAGroup != nil )
            {
                pickerView.backgroundColor = UIColor.white

                return allPickerSessionsForAGroup.count + 1
                
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
            
                let session = allPickerSessionsForAGroup[row - 1]
                
                return "\(session.week_day!) from:\(session.start_time!) to:\(session.end_time!)"
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

                allPickerSessionsForAGroup = nil
                
                savedSessionBtnPicker.reloadAllComponents()
            }
            else{
                
                pickerSelectedSession = nil
                //savedSessionBtnPicker.isHidden = false

                allPickerSessionsForAGroup = sessionViewModel.getGroupSessions(studentsGroup: allPickerGroups[row - 1])

                savedSessionBtnPicker.reloadAllComponents()
                
                savedSessionBtnPicker.selectRow(0, inComponent: 0, animated: false)

            }
            
        }
        else    if pickerView.tag == 20{
            
            if(row == 0)
            {
                pickerSelectedSession = nil
            }
            else{
                
                pickerSelectedSession = allPickerSessionsForAGroup[row - 1]
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


