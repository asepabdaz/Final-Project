//
//  AlamatTableViewController.swift
//  Final Project
//
//  Created by Asep Abdaz on 15/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class AlamatTableViewController: UITableViewController {

    @IBOutlet weak var noteExtraTextView: UITextView!
    @IBOutlet weak var mapCaptureImage: UIImageView!
    @IBOutlet weak var kategoriAlamat: UITextField!
    @IBOutlet weak var provinsiAlamat: UITextField!
    @IBOutlet weak var almatLengkapTextView: UITextView!
    @IBOutlet weak var kotaTextField: UITextField!
    @IBOutlet weak var kecamatanTextField: UITextField!
    @IBOutlet weak var kodePosTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Alamat"
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushToMapKit))
        mapCaptureImage.addGestureRecognizer(tap)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc
    func pushToMapKit() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Keranjang", bundle: nil)
        let newController = storyBoard.instantiateViewController(identifier: "mapKitStoryboard")
        self.navigationController?.pushViewController(newController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let kategoriAlamat = UserDefaults.standard.value(forKey: "KategoriAlamat") as? String {
            self.kategoriAlamat.text = kategoriAlamat
        }
        if let provAlamat = UserDefaults.standard.value(forKey: "Provinsi") as? String {
            self.provinsiAlamat.text = provAlamat
        }
        
        if let alamatLengkap = UserDefaults.standard.value(forKey: "AlamatLengkap") as? String {
            self.almatLengkapTextView.text = alamatLengkap
        }
        
        if let kota = UserDefaults.standard.value(forKey: "Kota")  as? String{
            self.kotaTextField.text = kota
        }
        if let kecamatan = UserDefaults.standard.value(forKey: "Kecamatan") as? String {
            self.kecamatanTextField.text = kecamatan
        }
        
        if let kodePos = UserDefaults.standard.value(forKey: "KodePos") as? String {
            self.kodePosTextField.text = kodePos
        }
        
        if let noteExtra = UserDefaults.standard.value(forKey: "NoteExtra") as? String {
            self.noteExtraTextView.text = noteExtra
        }
        
        if UserDefaults.standard.value(forKey: "coorDinate") != nil{
            mapCaptureImage.image = UIImage(named: "maps")
        }

    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
