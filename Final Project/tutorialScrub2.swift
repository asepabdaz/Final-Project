//
//  tutorialScrub_2.swift
//  Final Project
//
//  Created by Christian Widjaja on 20/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class tutorialScrub2: UIViewController {

    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bowl: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    
    var miniStep = 0
    var currentStep = 0
    var currentItem = 0
    
    let stepText = ["Langkah 1: Tuang ampas kopi ke dalam mangkuk", "Langkah 2: Tuang minyak kelapa ", "Langkah 3: Campur semua bahan", "Langkah 4: Tuang tepung tapioka ke dalam mangkuk","Langkah 5: Aduk hingga tercampur rata","Langkah 6: Teteskan minyak essensial", "Langkah 7: Aduk hingga tercampur rata"]
    let descriptionText = ["Kurang Lebih 8-12 sendok makan ya guys!", "3 Sendok Makan Ya!", "Diaduk sampai tercampur rata ya, kak!", "Tambahkan sekitar 3 sendok ya","","3 tetes sudah cukup", ""]
    let itemName = ["Ampas Kopi", "Minyak kelapa","", "Tepung Tapioka","", "Essential Oil", ""]
    
    var tempX: CGFloat = 0
    var tempY: CGFloat = 0

    
    override func viewDidLoad() {
         super.viewDidLoad()
        tempX = itemImage.center.x
        tempY = itemImage.center.y
        updateLabel()
    }
    
    func updateLabel(){
        stepLabel.text = stepText[currentStep]
        descriptionLabel.text = descriptionText[currentStep]
        nameLabel.text = itemName[currentStep]
        
        if currentStep == 1 {
            itemImage.image = UIImage(named: "Coconut oil.png")
        }
        if currentStep == 3 {
            itemImage.image = UIImage(named: "Flour.png")
        }
        if currentStep == 5 {
            itemImage.image = UIImage(named: "Essential Oil.png")
        }
        
    }
    

    // MARK: Gesture
    
    
    @IBAction func item(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
        let translation = recognizer.translation(in: view)
        recognizer.view?.center.x += translation.x
        recognizer.view?.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
        
        
        
        if recognizer.state == .ended {
        
        if itemImage.frame.intersects(bowl.frame){
            miniStep += 1
        }
        
            recognizerView.center.x = tempX
            recognizerView.center.y = tempY
        
        if currentStep == 0 {
            
            if miniStep == 8 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
        }
        
        
        if currentStep == 1 {
            
            if miniStep == 3 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
        
        }
        
        if currentStep == 2 {
            //Gesture goyang 1 jari
            if miniStep == 0 {
                currentStep += 1
                currentItem += 1
                updateLabel()
            }
        }
            
        if currentStep == 3 {
        
            if miniStep == 3 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
            }
        }
            
        if currentStep == 4 {
            //Gesture goyang 1 jari
            if miniStep == 0 {
                currentStep += 1
                currentItem += 1
                updateLabel()
            }
        }
            
        if currentStep == 5 {
                
            if miniStep == 3 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
        }
            
        if currentStep == 6 {
            //Gesture 1 jari
        }
        
        }
        
        
    }

}
