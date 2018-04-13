//
//  StudentViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 30/03/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentNameTxtField: UITextField!
    
    @IBOutlet weak var studentGenderSegement: UISegmentedControl!
    
    @IBOutlet weak var studentDOBPicker: UIDatePicker!
    
    @IBOutlet weak var studentPhoneTxtField: UITextField!
    
    @IBOutlet weak var studentEmailTxtField: UITextField!
    
    @IBOutlet weak var studentAddressTxtField: UITextField!
    
    let picker = UIImagePickerController()

    
    var oldStudent: Student?
    var studentGroup: Group?
    
    let studentViewModel = StudentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fillOldStudent()
        
        
        let saveStudentBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStudent))
        
        self.navigationItem.rightBarButtonItem = saveStudentBtn
        
        
        picker.delegate = self
        
        studentImage.isUserInteractionEnabled = true
        
        let barcodeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(StudentViewController.studentImageTapped))
        
        studentImage.addGestureRecognizer(barcodeTapRecognizer)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillOldStudent()
    {
        if let oldStudent = oldStudent {
            
            if let image = UIImage(data: oldStudent.photo!){
                
                studentImage.image! = image
            }
            
            if let name = oldStudent.name{
                
                studentNameTxtField.text! = name
            }
            
            if let phone = oldStudent.phone{
                
                studentPhoneTxtField.text! = phone
            }
            
            if let email = oldStudent.email{
                
                studentEmailTxtField.text! = email
            }
            
            if let address = oldStudent.address{
                
                studentAddressTxtField.text! = address
            }
            
            if(oldStudent.gender_ismale)
            {
                studentGenderSegement.selectedSegmentIndex = 0
            }
            else{
                studentGenderSegement.selectedSegmentIndex = 1
            }
            
            if let date = oldStudent.date_of_birth
            {
                studentDOBPicker.setDate(date, animated: true)

            }
            
        }
    }
    
    @objc func studentImageTapped() {
        
        let PhotoAlert = UIAlertController(title: "Options", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        PhotoAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction!) in
            
            self.useCamera()
            
        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action: UIAlertAction!) in
            
            self.userPhotoLibrary()
            
        }))
        
        present(PhotoAlert, animated: true, completion: nil)
    }
    
    func userPhotoLibrary()
    {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    
    func useCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        if let image = info[UIImagePickerControllerOriginalImage]
        {
            studentImage.image!  = image as! UIImage
        }
        
        dismiss(animated:true, completion: nil)


    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated:true, completion: nil)
        
    }
    
    @objc func saveStudent()
    {
        if(studentNameTxtField.text!.isEmpty)
        {
            alertEmptyName()
        }
        else {
            
            var isMale = false
            
            if studentGenderSegement.selectedSegmentIndex == 0
            {
                isMale = true
            }
            
            
            if let oldStudent = oldStudent
            {
                studentViewModel.updateAStudent(oldStudent: oldStudent, studentName: studentNameTxtField.text, studentEmail: studentEmailTxtField.text, studentAddress: studentAddressTxtField.text, studentPhone: studentPhoneTxtField.text, studentPhoto: studentImage.image!, studentDateOfBirth: studentDOBPicker.date, studentIsMale: isMale)
            }
            else if let studentGroup = studentGroup{
                
               
                studentViewModel.addANewStudent(studentName: studentNameTxtField.text, studentEmail: studentEmailTxtField.text, studentAddress: studentAddressTxtField.text, studentPhone: studentPhoneTxtField.text, studentPhoto: studentImage.image!, studentDateOfBirth: studentDOBPicker.date, studentIsMale: isMale, studentGroup: studentGroup)
            }
            
            navigationController?.popViewController(animated: true)

        }
        
    }
    
    func alertEmptyName()
    {
        let alert = UIAlertController(title: "Error", message: "Student name can't be empty", preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        let deleteAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
            
            
        })
        
        alert.addAction(deleteAction)
        
        self.present(alert, animated: true)
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
