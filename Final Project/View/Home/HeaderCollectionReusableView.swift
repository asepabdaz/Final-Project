//
//  HeaderCollectionReusableView.swift
//  Final Project
//
//  Created by Hai on 13/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var nameAppLabel: UILabel!
    
//    var nameApp: String!{
//        didSet{
//            nameAppLabel.text = nameApp
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        nameAppLabel.text = "Welcome"
        backgroundColor = .red
        // Initialization code
    }
    
}
