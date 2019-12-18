//
//  KeranjangViewController.swift
//  Final Project
//
//  Created by Asep Abdaz on 13/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit
import Combine

class KeranjangViewController: UIViewController {
    var transactionModel: TransactionModel!
    var timeCurrent: String?
    var keranjang: KeranjangTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            case 6..<12 : timeCurrent = NSLocalizedString("Morning", comment: "Morning")
            case 12 : timeCurrent = NSLocalizedString("Noon", comment: "Noon")
            case 13..<17 : timeCurrent = NSLocalizedString("Afternoon", comment: "Afternoon")
            case 17..<22 : timeCurrent = NSLocalizedString("Evening", comment: "Evening")
            default: timeCurrent = NSLocalizedString("Night", comment: "Night")
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkOut(_ sender: UIButton) {
        
//        print(keranjang?.quantityTextField.text)
        let alert = UIAlertController(title: "Beli Barang", message: "Anda akan di arahkan ke whatsapp untuk pemesanan, apakah setuju", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (alert) in
            let quantity: String = (self.keranjang?.quantityTextField.text)!
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            let formattedTipAmount = formatter.string(from: self.transactionModel.harga as NSNumber)
            let harga: String = "Rp. \(formattedTipAmount!)".replacingOccurrences(of: " ", with: "%20")
            let namaUser: String = (self.keranjang?.namaUserTextField.text)!.replacingOccurrences(of: " ", with: "%20")
            guard let url = URL(string: "https://wa.me/628388822223?text=Good%20\(self.timeCurrent!)%0ASaya%20ingin%20membeli%20produk%20:%0A%0ANama%20:%20\(self.transactionModel.namaBarang.replacingOccurrences(of: " ", with: "%20"))%0AJumlah%20:%20\(quantity)%0AHarga%20:%20\(harga)%0A%0ADan%20dikirim%20ke:%0ANama%20:%20\(namaUser)%0AAlamat%20:%20Jl.%20Asintan%20Sampora%0ATerima%20kasih") else { return }
             UIApplication.shared.open(url)
        }))
        alert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "EmbedDataChackOut" {
            let childDestination = segue.destination as? KeranjangTableViewController
            
//            childDestination?.nameItem = "Ampas Kopi"
            childDestination?.transactionModel = transactionModel
            keranjang = childDestination!
            
        }else{
            
        }
    }
    
    func alertYes(){
        
    }
    


}
