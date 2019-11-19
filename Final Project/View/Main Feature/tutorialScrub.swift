//
//  tutorialScrub.swift
//  Final Project
//
//  Created by Christian Widjaja on 14/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class tutorialScrub: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var currentTouch: UILabel!
    
    @IBOutlet weak var bowl: UIImageView!
    @IBOutlet weak var coffee: UIImageView!
    @IBOutlet weak var coconutOil: UIImageView!
    @IBOutlet weak var flour: UIImageView!
    @IBOutlet weak var essentialOil: UIImageView!
    
    @IBOutlet weak var dismisButton: UIButton!
    var currentStep = 0
    var miniStep = 0
    var temp: CGPoint?
    
    @IBOutlet weak var handImageView: UIImageView!
    
  
    
    
    var descriptionText = ["Step 1: Put coffee grounds into the bowl", "Step 2: Put coconut oil into bowl", "Step 3: Mix all ingredients", "Step 4: Put cornstarch in", "Step 5: Mix together again until evenly", "Step 6: Put 2-3 drops of essential oil (optional)", "Step 7: Mix together"]
    var instructionText = ["Add 8 tablespoons", "We need 3 tablespoon", "", "Add around 3 tablespoon", "", "We need 3 drops", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        currentTouch.text = ""
        dismisButton.layer.cornerRadius = dismisButton.frame.width / 2
        print(handImageView.frame.size)

    }
    override func viewDidAppear(_ animated: Bool) {
        temp = self.handImageView.center
        animate()
    }
        func animate(){
            UIImageView.animate(withDuration: 2, delay: 0, options: .repeat, animations: {
//            self.handImageView.center.x = self.bowl.center.x
            self.handImageView.center = self.bowl.center
//            (self.handImageView.center.x, self.handImageView.center.y) = (self.bowl.center.x, self.bowl.center.y)
            print("true")
        }, completion: nil)
            
            
        
    }
    
    func updateLabel(){
        descriptionLabel.text = descriptionText[currentStep]
        instructionLabel.text = instructionText[currentStep]
    }
    
    //MARK:================ Gesture
    
    @IBAction func coffee(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else{
            return
        }
                
        let translation = recognizer.translation(in: view)
        recognizer.view?.center.x += translation.x
        recognizer.view?.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)

        
        if recognizer.state == .began {
            currentTouch.text = "coffee ground"
            handImageView.alpha = 0
            handImageView.layer.removeAllAnimations()
            print(handImageView.animationRepeatCount)
        }
        
        if recognizer.state == .ended {
            
            
            handImageView.alpha = 1
            handImageView.center = temp!
            animate()
            currentTouch.text = ""
            
            if (bowl.frame.intersects(coffee.frame)){
                miniStep += 1
                if miniStep == 1 {
                    bowl.image = UIImage(named: "BowlVer1.png")
                } else if miniStep == 4 {
                    bowl.image = UIImage(named: "BowlVer2.png")
                } else if miniStep == 8 {
                    bowl.image = UIImage(named: "BowlVer3.png")
                }
                instructionLabel.text = "Add \(8-miniStep) tablespoons"
            }
            
            if miniStep == 8 {
                currentStep = 1
                coffee.isUserInteractionEnabled = false
                coconutOil.isUserInteractionEnabled = true
                updateLabel()
                handImageView.layer.removeAllAnimations()
                handImageView.center = coconutOil.center
            }
            
            recognizerView.center.x = 60
            recognizerView.center.y = 738
        }
    
    }
    
    @IBAction func coconutOil (_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else{
            return
        }
        
        let translation = recognizer.translation(in: view)
        recognizer.view?.center.x += translation.x
        recognizer.view?.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
        
        if recognizer.state == .began {
            currentTouch.text = "coconut oil"
        }

        if recognizer.state == .ended {
            
            currentTouch.text = ""
            
            if (bowl.frame.intersects(coconutOil.frame)){
                miniStep += 1
                print(miniStep)
                instructionLabel.text = "We need \(11 - miniStep) tablespoon"
            }
            
            if miniStep == 11 {
                currentStep += 1
                updateLabel()
                coconutOil.isUserInteractionEnabled = false
                bowl.isUserInteractionEnabled = true
                
                
            }
            
            recognizerView.center.x = 165
            recognizerView.center.y = 742
        }
    
    }
    
    @IBAction func flour (_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else{
            return
        }
        
        let translation = recognizer.translation(in: view)
        recognizer.view?.center.x += translation.x
        recognizer.view?.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
        
        if recognizer.state == .ended {
            
            
            if (bowl.frame.intersects(flour.frame)){
                miniStep += 1
                print(miniStep)
                instructionLabel.text = "Add around \(15 - miniStep) tablespoon"
            }
            
            if miniStep == 15 {
                currentStep += 1
                updateLabel()
                flour.isUserInteractionEnabled = false
                bowl.isUserInteractionEnabled = true
            }
            
            recognizerView.center.x = 282
            recognizerView.center.y = 738
        }
    
    }
    
    @IBAction func essentialOil (_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else{
            return
        }
        
        let translation = recognizer.translation(in: view)
        recognizer.view?.center.x += translation.x
        recognizer.view?.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
        
        if recognizer.state == .ended {
            
            print("masuk")
            if (bowl.frame.intersects(essentialOil.frame)){
                miniStep += 1
                print(miniStep)
                instructionLabel.text = "We need \(19 - miniStep) drops"
            }
            
            if miniStep == 19 {
                currentStep += 1
                updateLabel()
                essentialOil.isUserInteractionEnabled = false
                bowl.isUserInteractionEnabled = true
            }
            
            recognizerView.center.x = 361
            recognizerView.center.y = 776
        }
    
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func bowl(_ recognizer: UIRotationGestureRecognizer) {
        guard recognizer.view != nil else{
            return
        }
        

//        if recognizer.state == .began || recognizer.state == .changed {
//
//
//            if miniStep == 11{
//                miniStep += 1
//            if miniStep == 12 {
//                currentStep += 1
//                updateLabel()
//                bowl.isUserInteractionEnabled = false
//                flour.isUserInteractionEnabled = true
//                print(miniStep)
//                }
//            } else if miniStep == 15 {
//                miniStep += 1
//
//                if miniStep == 16 {
//                    currentStep += 1
//                    updateLabel()
//                    bowl.isUserInteractionEnabled = false
//                    essentialOil.isUserInteractionEnabled = true
//                }
//
//            } else if miniStep == 19 {
//                miniStep += 1
//                if miniStep == 20{
//                    bowl.isUserInteractionEnabled = false
//                }
//            }
        
        //add gesture recognizer

        
    }
//    override var statusBarAnimatableConfig: StatusBarAnimatableConfig {
//        return StatusBarAnimatableConfig(prefersHidden: true,
//                                         animation: .slide)
//    }
//    
    override var prefersStatusBarHidden: Bool{
        return true
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
