//
//  AddingGroupPopupViewController.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 3/29/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class AddingGroupPopupViewController: UIViewController {

    @IBOutlet weak var grouNameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var AddingGroupTitleLbl: UILabel!
    
    @IBOutlet weak var sessionPriceTitleLbl: UILabel!
    
    @IBOutlet weak var subscriptionPriceTitleLbl: UILabel!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var subscriptionPriceTextField: UITextField!
    
    @IBOutlet weak var shownView: UIView!
    var selectedGroup: Group?
    
    var allGroups = MainViewModel().getGroups()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        shownView.layer.cornerRadius = 30
        shownView.layer.masksToBounds = true
        
        priceTextField.keyboardType = UIKeyboardType.numberPad
        
        priceTextField.text! = "0"
        
        subscriptionPriceTextField.keyboardType = UIKeyboardType.numberPad
        
        subscriptionPriceTextField.text! = "0"
        
        if let group = selectedGroup {
            
            grouNameTextField.text = group.name
            
            priceTextField.text! = "\(group.session_price)"
            
            subscriptionPriceTextField.text! = "\(group.subscription_price)"

        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        prepareLayout()
    }
    
    func prepareLayout(){
        
        self.title = langauageStrings.GroupTitle
        
        shownView.backgroundColor = secondaryColor
        
        AddingGroupTitleLbl.text = langauageStrings.addingGroupTitle
        
        AddingGroupTitleLbl.textColor = primaryColor
        
        subscriptionPriceTitleLbl.text = langauageStrings.subscriptionPriceTitle
        
        subscriptionPriceTitleLbl.textColor = primaryColor

        sessionPriceTitleLbl.text = langauageStrings.sessionPriceTitle
        
        sessionPriceTitleLbl.textColor = primaryColor
        
        cancelButton.titleLabel?.text = langauageStrings.cancelButtonTitle
        
        submitButton.titleLabel?.text = langauageStrings.submitButtonTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func submitGroupName(_ sender: Any) {
        
        
        if(grouNameTextField.text!.isEmpty)
        {
         
            showAlert(message: "Group name can't be empty")
        }
        else{
            
            if allGroups.count > 0 {
                
                for group in allGroups{
                    
                    if group.name! ==  grouNameTextField.text! && group.objectID != selectedGroup?.objectID{
                        
                        showAlert(message: "Another group with the same name exists")
                        return
                    }
                }
            }
         
            if let group = selectedGroup {
                
                MainViewModel().updateAgroup(oldGroup: group, newName: grouNameTextField.text!, newSessionPrice: Int(priceTextField.text!)!, newSubscriptionPrice:  Int(subscriptionPriceTextField.text!)!)
            }
                
            else {
                
                MainViewModel().addANewGroup(groupName: grouNameTextField.text!, sessionPrice: Int(priceTextField.text!)!, subscriptionPrice: Int(subscriptionPriceTextField.text!)!)
            }
            
            dismiss(animated: true, completion: nil)

        }

    }
    
    func showAlert(message: String!){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
        })
        
        alert.addAction(okAction)
        
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
