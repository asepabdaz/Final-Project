//
//  HeaderView.swift
//  Final Project
//
//  Created by Asep on 04/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UIButton!
    @IBOutlet weak var corner: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {

        corner.layer.cornerRadius = corner.bounds.width / 2
        imageView.layer.cornerRadius = imageView.bounds.width / 2

        titleLabel.mask = corner
        let tap = UITapGestureRecognizer(target: self, action: #selector(setImage))
        corner.addGestureRecognizer(tap)
    }
    @objc
    func setImage() {
        print("test")
    }
    
//    @IBAction func setImageButton(_ sender: UIButton) {
//        print("test")
//    }
}
