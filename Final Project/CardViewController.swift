//
//  CardViewController.swift
//  Final Project
//
//  Created by Ivan Sebastian on 28/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        cell.ImageCardView.image = imageView[indexPath.row]
        
        cell.labelTitle.text = titleName[indexPath.row]
        
        cell.labelDesc.text = desc[indexPath.row]
        
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
        
    }
    
    
    let imageView = [UIImage(named: "Cards 1"), UIImage(named: "Cards 2"), UIImage(named: "Cards 3")]
    
    let titleName = ["How to Scrub" , "Coffee Aroma","DIY Coffee Candle"]
    
    let desc = ["with coffee grounds as your main ingredients" , "indulge your warm, cozy home with scent of coffee", "experience the rejuvenating smell of coffee, made by you"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.title = "Welcome, Ivan"
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



