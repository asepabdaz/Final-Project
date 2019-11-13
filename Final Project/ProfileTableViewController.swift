//
//  ProfileTableViewController.swift
//  Final Project
//
//  Created by Christian Widjaja on 05/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

        var profile = ["Nama", "Umur", "Tinggi", "Berat"]
        var data = ["popo", "10", "100", "90"]
        
        @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
            let detailViewController = segue.source as! DetailTableViewController
            
               let index = detailViewController.index
            
               let modelString = detailViewController.editedModel
                
               data[index!] = modelString!
            
               tableView.reloadData()
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */

        /*
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        */

        /*
        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        }
        */

        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the item to be re-orderable.
            return true
        }
        */

         //MARK: - Navigation


        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "edit" {
             
                let path = tableView.indexPathForSelectedRow
             
                let detailViewController = segue.destination as! DetailTableViewController
    
                detailViewController.index = path?.row
                detailViewController.modelArray = data
                detailViewController.profilArray = profile
                
                print(data)
             
                }
            print("ok")
        }


    }
