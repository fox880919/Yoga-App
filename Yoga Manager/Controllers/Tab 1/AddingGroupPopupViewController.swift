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
    
    @IBOutlet weak var subscriptionPriceTextField: UITextField!
    
    var selectedGroup: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func submitGroupName(_ sender: Any) {
        
        if let group = selectedGroup {
            
            MainViewModel().updateAgroup(oldGroup: group, newName: grouNameTextField.text!, newSessionPrice: Int(priceTextField.text!)!, newSubscriptionPrice:  Int(subscriptionPriceTextField.text!)!)
        }
        
        else {
            
            MainViewModel().addANewGroup(groupName: grouNameTextField.text!, sessionPrice: Int(priceTextField.text!)!, subscriptionPrice: Int(subscriptionPriceTextField.text!)!)
        } 
        
        dismiss(animated: true, completion: nil)

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
