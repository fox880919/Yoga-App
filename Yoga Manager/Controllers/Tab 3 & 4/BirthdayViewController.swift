//
//  BirthdayViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 22/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    @IBOutlet weak var birthdayTableView: UITableView!
    
    var allStudents: [Student]!
    
    var organizedStudents: [[Student]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        birthdayTableView.dataSource = self
        
        birthdayTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        

        allStudents = StudentViewModel().getAllStudents()
        
        organizedStudents = [[Student]]()

        if(allStudents.count > 0)
        {
            var i = 0
            
            while (i < 12)
            {
                
                organizedStudents.append([Student]())
                
                i = i + 1
            }
            
            
            for student in allStudents{
                
                if(student.date_of_birth == nil)
                {
                    
                    let studentBirthdayMonthNumber = getMonthFromDate(date: student.date_of_birth!)
                    
                    organizedStudents[studentBirthdayMonthNumber - 1].append(student)
                }
            }
            
            for var oneMonthstudents in organizedStudents{
                
                oneMonthstudents = oneMonthstudents.sorted(by: {
                    $0.date_of_birth!.compare($1.date_of_birth!) == .orderedAscending
                })
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension BirthdayViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return organizedStudents[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCell")!
        
            let student = organizedStudents[indexPath.section][indexPath.row]
        
            cell.textLabel?.text = student.name
        
            cell.detailTextLabel?.text = stringFromDate(date: student.date_of_birth!)
        
            return cell //4.

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
}
