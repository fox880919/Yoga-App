//
//  SettingsViewController.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/12/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var langauageSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var locationTableView: UITableView!
    
    let locationViewModel = LocationModelView()
    
    var selectedLocation: Location!
    
    var allLocations: [Location]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = primaryColor
        
        locationTableView.backgroundColor = primaryColor
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        allLocations = locationViewModel.getAllLocations()

        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
        
        self.navigationItem.rightBarButtonItem = saveBtn
        
        if(isArabic())
        {
            langauageSegmentedControl.selectedSegmentIndex = 1
        }
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        allLocations = locationViewModel.getAllLocations()
   
        locationTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func saveBtnPressed()
    {
        let languageIndex = langauageSegmentedControl.selectedSegmentIndex
        
        if(languageIndex == 1)
        {
            saveLang(isArabic: true)
        }
        else{
            saveLang(isArabic: false)
        }
        
        navigationController?.popViewController(animated: true)

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

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return allLocations.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")  as! LocationTableCell
        
            let thisLocation = allLocations[indexPath.row]
                    
            cell.locationNameLbl.text = thisLocation.name //3.
        
            let address = thisLocation.address?.replacingOccurrences(of: "\n", with: ", ")
        
            cell.addressLbl.text = address //3.

            cell.googleUrlLbl.text =  thisLocation.latitude! + "," + thisLocation.longitude! //3.

            return cell //4.
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedLocation = allLocations[indexPath.row]
        
        performSegue(withIdentifier: "goToLocationSegue", sender: self)

    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {

            let deleteLocationAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let alert = UIAlertController(title: "Deleting \(self.allLocations[indexPath.row].name!) Location", message: "Are your sure?", preferredStyle: UIAlertControllerStyle.alert)
                
                
                
                let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                    
                    self.locationViewModel.deleteALocation(entity: self.allLocations[indexPath.row])
                    
                    self.allLocations = self.locationViewModel.getAllLocations()
                    
                    tableView.reloadData()
                    
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
            })
        
        
        let copyLocationAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Copy URL" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let thisLocation = self.allLocations[indexPath.row]
            
            UIPasteboard.general.string = googleURL + thisLocation.latitude! + "," + thisLocation.longitude!
        })
        
            return [deleteLocationAction, copyLocationAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150;//Choose your custom row height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToLocationSegue" {
            
            if let destination = segue.destination as? SessionMapViewController{
                
                destination.title = "Location"
                
                destination.currentLocation = selectedLocation
                
            }
        }
        
    }
}
