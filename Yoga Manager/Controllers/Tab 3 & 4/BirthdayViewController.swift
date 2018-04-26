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
                
                if(student.date_of_birth != nil)
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
        
        birthdayTableView.dataSource = self
        
        birthdayTableView.delegate = self
        
        birthdayTableView.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 12
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "January"
        case 1:
            return "February"
        case 2:
            return "March"
        case 3:
            return "April"
        case 4:
            return "May"
        case 5:
            return "June"
        case 6:
            return "July"
        case 7:
            return "August"
        case 8:
            return "September"
        case 9:
            return "October"
        case 10:
            return "November"
        case 11:
            return "December"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(organizedStudents.count > 0)
        {
            return organizedStudents[section].count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCell")!

        
            let student = organizedStudents[indexPath.section][indexPath.row]
        
            cell.textLabel?.text = student.name
        
            cell.detailTextLabel?.text = stringFromDate(date: student.date_of_birth!)
        
            cell.contentView.backgroundColor = primaryColor
        
            let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 90))
        
            whiteRoundedView.layer.masksToBounds = true
        
            whiteRoundedView.backgroundColor = secondaryColor
        
            whiteRoundedView.layer.cornerRadius = 30

            cell.contentView.addSubview(whiteRoundedView)
        
            cell.contentView.sendSubview(toBack: whiteRoundedView)
        
            return cell //4.

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 30
    }

    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        view.tintColor = primaryColor
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 20)!
        
        header.textLabel?.textAlignment = .center
        
        header.textLabel?.textColor = secondaryColor
        
        header.backgroundView?.backgroundColor = primaryColor
    }
}
