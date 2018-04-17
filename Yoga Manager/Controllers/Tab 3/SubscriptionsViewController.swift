//
//  SubscriptionsViewController.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 16/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit

class SubscriptionsViewController: UIViewController {

    @IBOutlet weak var subscriptionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subscriptionTableView.dataSource = self
        subscriptionTableView.delegate = self
        // Do any additional setup after loading the view.
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

extension SubscriptionsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subscriptionCell", for: indexPath)
            as! SubscriptionCell
        
       return cell
    }
    
    
}
