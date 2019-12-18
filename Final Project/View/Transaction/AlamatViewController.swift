//
//  AlamatViewController.swift
//  Final Project
//
//  Created by Asep Abdaz on 18/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class AlamatViewController: UIViewController {

    var detailAddress: AlamatTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAddress(_ sender: UIButton) {
        saveToUserDefault()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailAddress" {
            let childDestination = segue.destination as? AlamatTableViewController
            
            detailAddress = childDestination!
            
        }else{
            
        }
    }
    func saveToUserDefault() {
        //Kategori
        let kategoriAlamat: String = (detailAddress?.kategoriAlamat.text)!
        UserDefaults.standard.set(kategoriAlamat, forKey: "KategoriAlamat")
        //AlamatLengkap
        let alamatLengkap: String = (detailAddress?.almatLengkapTextView.text)!
        UserDefaults.standard.set(alamatLengkap, forKey: "AlamatLengkap")
        //Provinsi
        let provinsi: String = (detailAddress?.provinsiAlamat.text)!
        UserDefaults.standard.set(provinsi, forKey: "Provinsi")
        //Kota
        let kota: String = (detailAddress?.kotaTextField.text)!
        UserDefaults.standard.set(kota, forKey: "Kota")
        //Kecamatan
        let kecamatan: String = (detailAddress?.kecamatanTextField.text)!
        UserDefaults.standard.set(kecamatan, forKey: "Kecamatan")
        //Kode Pos
        let kodePos: String = (detailAddress?.kodePosTextField.text)!
        UserDefaults.standard.set(kodePos, forKey: "KodePos")
        //Catatan Tambahan
        let noteExtra: String = (detailAddress?.noteExtraTextView.text)!
        UserDefaults.standard.set(noteExtra, forKey: "NoteExtra")
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: KeranjangViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

