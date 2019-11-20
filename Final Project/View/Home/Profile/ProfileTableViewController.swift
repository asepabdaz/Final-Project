//
//  ProfileTableViewController.swift
//  Final Project
//
//  Created by Christian Widjaja on 05/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

        // Profile
    var profile = ["Nama", "Email", "Phone", "Alamat"]
    let defaults = UserDefaults.standard
    var data: [String] = []
        
        @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
            let detailViewController = segue.source as! DetailTableViewController
            
            let index = detailViewController.index
            
            let modelString = detailViewController.editedModel
            var newData = defaults.array(forKey: "dataProfile")  as? [String] ?? [String]()
            newData[index!] = modelString!
            UserDefaults.standard.set(newData, forKey: "dataProfile")
            tableView.reloadData()
        }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        data = defaults.array(forKey: "dataProfile")  as? [String] ?? [String]()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        tableView.isScrollEnabled = false
        return profile.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        cell.textLabel?.text = profile[indexPath.row]
        
        let label = cell.contentView.viewWithTag(100) as! UILabel
        label.text = data[indexPath.row]
        
        return cell
    }


     //MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "edit" {
         
            let path = tableView.indexPathForSelectedRow
         
            let detailViewController = segue.destination as! DetailTableViewController

            detailViewController.index = path?.row
            detailViewController.modelArray = data
            detailViewController.profilArray = profile
         
        }
    }


}
