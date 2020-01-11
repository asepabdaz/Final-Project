//
//  TransactionModel.swift
//  Final Project
//
//  Created by Asep on 12/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import Foundation
import UIKit

class TransactionModel {
    var namaBarang: String
    var material: [[String: String]]
    var harga: Int
    var jumlah: Int
    var imageView: UIImage
    
    init(_ namaBarang: String, _ material: [[String: String]], _ harga: Int, _ jumlah: Int, _ imageView: UIImage) {
        self.namaBarang = namaBarang
        self.material = material
        self.harga = harga
        self.jumlah = jumlah
        self.imageView = imageView
    }
}
