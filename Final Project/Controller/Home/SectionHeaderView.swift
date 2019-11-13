//
//  SectionHeaderView.swift
//  Final Project
//
//  Created by Hai on 11/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var nameAppsLabel: UILabel!
    
    var nameApp: String!{
        didSet{
            nameAppsLabel.text = nameApp
        }
    }
    
}
