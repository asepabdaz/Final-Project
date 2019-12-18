//
//  KeranjangTableViewController.swift
//  Final Project
//
//  Created by Asep Abdaz on 14/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit



class KeranjangTableViewController: UITableViewController {

    var transactionModel: TransactionModel!

    //MARK: data to get
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var namaBarang: UILabel!
    @IBOutlet weak var desBarang: UILabel!
    @IBOutlet weak var noTelpTextField: UITextField!
    @IBOutlet weak var namaUserTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var feeDelevery: Int?
    var total: Int?
    
    //TODO: Delete
    @IBAction func nameUser(_ sender: UITextField) {
        print(sender.text!)
    }
    
    
    @IBAction func changeData(_ sender: UITextField) {
        let data = sender.text
        var dataInt: Int!
        if data == "" {
            dataInt = 0
        }else{
            if Int("\(data!)")! >= Int(jumlahBarang.maximumValue) {
                dataInt = Int(jumlahBarang.maximumValue)
                sender.text = "\(dataInt!)"
            }else{
                dataInt = Int("\(data!)")
            }
            
        }
        print(dataInt!)
        jumlahBarang.value = Double(dataInt)
    }
    @IBAction func checkStepper(_ sender: UIStepper) {
        quantityTextField.text = String(Int(jumlahBarang.value))
    }
    
    //MARK: Outlets MISC
    @IBOutlet weak var alamat: UITableViewCell!
    @IBOutlet weak var jumlahBarang: UIStepper!
    @IBOutlet weak var totalHargaLabel: UILabel!
    @IBOutlet weak var ongkirLabel: UILabel!
    @IBOutlet weak var totalHargaKeseluruhan: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEdit)))
        alamat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToAddress)))
        namaUserTextField.delegate = self
        noTelpTextField.delegate = self
        emailTextField.delegate = self
        
        
        namaBarang.text = transactionModel.namaBarang
        var dataMaterial = ""
        
        for (index, item) in transactionModel.material.enumerated() {
            let materialName: String = item["name"]!
            if index  == 0 {
                dataMaterial.append("\(index+1). \(materialName)")
            }else{
                dataMaterial.append("\n\(index+1). \(materialName)")
            }
        }
        

        desBarang.text = dataMaterial
        quantityTextField.text = "1"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: "coorDinate") != nil {
            alamat = AddressTableViewCell()
        }
        
    }
    
    //MARK: Object Selector
    
    @objc
    func endEdit() {
        self.view.endEditing(true)
    }
    @objc
    func pushToAddress() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Keranjang", bundle: nil)
        let newController = storyBoard.instantiateViewController(identifier: "alamatStoryBoard") as AlamatViewController
        self.navigationController?.pushViewController(newController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
           return CGFloat.leastNormalMagnitude
        }
        return UITableView.automaticDimension
        
    }
}

extension KeranjangTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


