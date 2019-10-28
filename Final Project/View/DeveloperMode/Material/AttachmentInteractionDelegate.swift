//
//  AttachmentInteractionDelegate.swift
//  Final Project
//
//  Created by Hai on 25/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

protocol AttachmentInteractionDelegate: class {
    
    func collectionView(_ collectionView: UICollectionView, didSelectedItemAt indexPath: IndexPath)

    func delete(attachment: Attachment, at indexPath: IndexPath)
}
