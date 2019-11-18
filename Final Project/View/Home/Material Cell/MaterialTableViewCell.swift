//
//  MaterialTableViewCell.swift
//  Final Project
//
//  Created by Hai on 14/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class MaterialTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMaterial: UIImageView!
    @IBOutlet weak var nameMaterial: UILabel!
    @IBOutlet weak var descMaterial: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        imageMaterial.contentMode = .scaleAspectFill
        // Configure the view for the selected state
    }
    
}
