//
//  MaterialModel.swift
//  Final Project
//
//  Created by Hai on 23/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import Foundation
import UIKit


class MaterialModel{
    var no: Int16
    var idMaterial: String
    var nameMaterial: String
    var descMaterial: String
    var imageMaterial: UIImage
    
    init(_ no: Int16, _ idMaterial: String, _ nameMaterial: String, _ descMaterial: String, _ imageMaterial: UIImage) {
        self.no =  no
        self.idMaterial = idMaterial
        self.nameMaterial = nameMaterial
        self.descMaterial = descMaterial
        self.imageMaterial = imageMaterial
    }
}
