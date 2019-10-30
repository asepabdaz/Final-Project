//
//  CardViewController.swift
//  Final Project
//
//  Created by Ivan Sebastian on 28/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        cell.ImageCardView.image = imageView[indexPath.row]
        
        cell.labelTitle.text = titleName[indexPath.row]
        
        cell.labelDesc.text = desc[indexPath.row]
        
        return cell
        
    }
    
    
    let imageView = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "Image3")]
    
    let titleName = ["How to Scrub" , "Coffee Aroma","DIY Coffee Candle"]
    
    let desc = ["with coffee grounds as your main ingredients" , "indulge your warm, cozy home with scent of coffee", "experience the rejuvenating smell of coffee, made by you"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
