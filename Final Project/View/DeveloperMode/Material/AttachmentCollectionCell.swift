//
//  AttachmentCollectionCell.swift
//  Final Project
//
//  Created by Hai on 25/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class AttachMentCollectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: AttachmentInteractionDelegate?
    
    var material: Material?
    
    
    
    private var validAttachments = [Attachment]()
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        guard isEditing != editing else { return }
        
        super.setEditing(editing, animated: animated)
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let material = material, let attachments = material.attachments?.allObjects as? [Attachment] else { return 0 }
        
//        validAttachments = attachments.filter { return
////            !($0.imageData == nil && $0.get)
//        }
        return validAttachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
