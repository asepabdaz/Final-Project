//
//  AttachmentCVCell.swift
//  Final Project
//
//  Created by Hai on 25/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class AttachmentCVCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: AttachmentInteractionDelegate?
    var attachment: Attachment!
    var indexPath: IndexPath!
    
    
    
    @IBAction func deleteAction(_ sender: UIButton) {
        delegate?.delete(attachment: attachment, at: indexPath)
    }
}
