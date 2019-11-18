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
    
    @IBOutlet weak var imageView: UIImageView!

    var nameApp: String!{
        didSet{
            nameAppLabel.text = nameApp
        }
    }
    var heightHeader = 40
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        heightAnchor.
        nameAppLabel.text = "Test"
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        // Initialization code
    }
    
    
}
