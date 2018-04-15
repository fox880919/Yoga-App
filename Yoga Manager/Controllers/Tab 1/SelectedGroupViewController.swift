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
        
        newInputView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 300))
        
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
        return "Sessions"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let sessionCount = sessionViewModel.getGroupSessions(studentsGroup: studentsGroup).count
        
        if(sessionCount > 0)
        {
            lastRowPosition = sessionCount
        }

        return sessionCount  + 1
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == lastRowPosition)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "addSessionCell")!
            
            cell.textLabel?.text = "Add a new session"
            
            return cell //4.
            
        }
        
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionsCell1") as! SessionCell
            
            let session = allGroupSessions[indexPath.row]
            
            cell.sessionDayLabel.text! = session.week_day!
            
            cell.sessionStartTimeLabel.text! = "\(session.start_time!)"

            cell.sessionsEndTimeLabel.text! = "\(session.end_time!)"

            return cell //4.
        }
     
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == lastRowPosition)
        {
            addSession()
        }
            
        else{
            
            selectedSession = allGroupSessions[indexPath.row]
            
            self.performSegue(withIdentifier: "editSessionSegue", sender: self)
            
        }

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        if (indexPath.row != lastRowPosition) {
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let alert = UIAlertController(title: "Deleting Session number \(indexPath.row + 1)", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
                
                
                
                let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                    
                    self.sessionViewModel.deleteASession (entity: self.allGroupSessions[indexPath.row])
                    
                    self.allGroupSessions = self.sessionViewModel.getGroupSessions(studentsGroup: self.studentsGroup)
                    
                    self.lastRowPosition = self.allGroupSessions.count

                    tableView.reloadData()
                    
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
        
        
        savedGroupsBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 100))
        
        savedGroupsBtnPicker.delegate = self
        savedGroupsBtnPicker.dataSource = self
        
        savedGroupsBtnPicker.backgroundColor = UIColor.white
        
        savedGroupsBtnPicker.showsSelectionIndicator = true
        
        savedGroupsBtnPicker.tag = 10;
        
        savedSessionBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 130, width: self.view.frame.size.width, height: 100))
        
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
        
        newInputView.backgroundColor = UIColor.cyan
        
        self.view.addSubview(newInputView)
        
    }
    
    @objc func donePicker(){
        
        savedGroupsBtnPicker.resignFirstResponder()
        
        newInputView.removeFromSuperview()
    }
    
    @objc func cancelPicker(){
        
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
        
        let test = pickerView.tag

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
        
        let test = pickerView.tag
        
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

                //savedSessionBtnPicker.isHidden = false

                allPickerSessionsForAGroup = sessionViewModel.getGroupSessions(studentsGroup: allPickerGroups[row - 1])
                
                let test = savedSessionBtnPicker.tag
                
                savedSessionBtnPicker.reloadAllComponents()
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


