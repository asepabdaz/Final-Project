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
    @IBOutlet weak var mainObject: UIImageView!
    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var mejaUIView: UIView!
    
    var miniStep = 0
    var currentStep = 0
    var currentItem = 0
    var imageName = ""
    
    let stepText = ["Langkah 1: Tuang ampas kopi ke dalam mangkuk", "Langkah 2: Tuang minyak kelapa ", "Langkah 3: Campur semua bahan", "Langkah 4: Tuang tepung tapioka ke dalam mangkuk","Langkah 5: Teteskan minyak essensial", "Langkah 6: Aduk hingga tercampur rata"]
    let descriptionText = ["Kurang Lebih 6-8 sendok makan ya guys!", "3 Sendok Makan Ya!", "Diaduk sampai tercampur rata ya, kak!", "Tambahkan sekitar 1 sendok ya","3 tetes sudah cukup", ""]
    let itemName = ["Ampas Kopi", "Minyak kelapa","", "Tepung Maizena","Essential Oil", "", ""]
    
    
    var tempX: CGFloat = 0
    var tempY: CGFloat = 0

    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        kopi😘 = createImageArray(total😘: 20, imagePrefix: "kopiPertama")
        
        
//        originImageView.alpha = 0
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
        if currentStep == 4 {
            itemImage.image = UIImage(named: "Essential Oil.png")
        }
        
    }
    
    var kopi😘: [UIImage] = []
    
    func createImageArray(total😘: Int, imagePrefix: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        for imageCount in 0..<total😘 {
            let imageName = "\(imagePrefix)-\(imageCount)"
            let image = UIImage(named: imageName)!
            imageArray.append(image)
            
        }
        return imageArray
    }
    func step(imageView: UIImageView, image: [UIImage]) {
        imageView.animationImages = image
        imageView.animationDuration = 0.7
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
        imageView.image = image.last
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
//           
        if itemImage.frame.intersects(mainObject.frame){
            miniStep += 1
        }
        
            recognizerView.center.x = tempX
            recognizerView.center.y = tempY
        
        if currentStep == 0 {
            if miniStep == 1 {

                step(imageView: mainObject, image: kopi😘)
                updateLabel()
            }
            if miniStep == 2 {
                step(imageView: mainObject, image: createImageArray(total😘: 12, imagePrefix: "kopiKedua"))
                
            }
            
            if miniStep == 3 {
                step(imageView: mainObject, image: createImageArray(total😘: 21, imagePrefix: "kopiKetiga"))
                
                updateLabel()
            }
            if miniStep == 4 {
                step(imageView: mainObject, image: createImageArray(total😘: 21, imagePrefix: "kopiKeempat"))
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
            
            
        }
        
        
        if currentStep == 1 {
            if miniStep == 1 {
                step(imageView: mainObject, image: createImageArray(total😘: 21, imagePrefix: "oilPertama"))
            }
            if miniStep == 2 {
                step(imageView: mainObject, image: createImageArray(total😘: 21, imagePrefix: "oilKedua"))
            }

            if miniStep == 3 {
                
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
                step(imageView: mainObject, image: createImageArray(total😘: 21, imagePrefix: "oilKetiga"))
                self.imageName = "S"
                self.view.addGestureRecognizer(CircleGesture(midPoint: mainObject.center, target: self, action: #selector(self.rotateGesture(recognizer:))))
                itemImage.isUserInteractionEnabled = false
                
            }
        }
        
            
        if currentStep == 3 {
        
            
            mainObject.image = UIImage(named: "CS\(miniStep)")
            if miniStep == 1 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
        }
            
        if currentStep == 4 {
            if miniStep == 0 {
                mainObject.image = UIImage(named: "CS0")
            } else{
            mainObject.image = UIImage(named: "esential\(miniStep)")
            }
            if miniStep == 3 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
        }
            
        if currentStep == 6 {
                
            if miniStep == 3 {
                currentStep += 1
                currentItem += 1
                miniStep = 0
                updateLabel()
            }
        }
            
        if currentStep == 5 {
            //Gesture 1 jari
            imageName = "mix"
            currentValue = 0
            self.view.addGestureRecognizer(CircleGesture(midPoint: mainObject.center, target: self, action: #selector(self.rotateGesture(recognizer:))))
            itemImage.isUserInteractionEnabled = false
            

        }
        
        }
        
        
    }
    
    var currentValue:CGFloat = 0.0{
            didSet {
                if (currentValue > 30) {
                    self.view.gestureRecognizers?.removeAll()
                    itemImage.isUserInteractionEnabled = true
                    if currentStep == 2 {
                        currentItem += 1
                        currentStep += 1
                        updateLabel()
                    } else if currentStep == 5{
                        weak var pvc = self.presentingViewController

                        self.dismiss(animated: false, completion: {
                            let vc = CongratViewController()
                            vc.modalPresentationStyle = .overFullScreen
                            pvc?.present(vc, animated: false, completion: nil)
                        })
                    }
                    
                }
                if (currentValue < 0) {
                    currentValue = 0
                }
            }
    }
    
    @objc func rotateGesture(recognizer: CircleGesture){
        
        if let rotation = recognizer.rotation {
            currentValue += rotation
            
            //MARK: asset perlu 31 gambar
            
//            nameLabel.text = "\(currentValue)"
            mainObject.transform =  CGAffineTransform(rotationAngle: currentValue)
            let putaran = currentValue / 2
            mainObject.image = UIImage(named: String(format: "\(imageName)%.0f%", putaran))

        }
                
    }

}
