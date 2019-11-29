//
//  CongratViewController.swift
//  Final Project
//
//  Created by Hai on 25/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

enum Colors {
    
    static let red = UIColor(red: 1.0, green: 0.0, blue: 77.0/255.0, alpha: 1.0)
    static let blue = UIColor.blue
    static let green = UIColor(red: 35.0/255.0 , green: 233/255, blue: 173/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 1, green: 209/255, blue: 77.0/255.0, alpha: 1.0)
    
}

enum Images {
    
    static let box = UIImage(named: "Box")!
    static let triangle = UIImage(named: "Triangle")!
    static let circle = UIImage(named: "Circle")!
    static let swirl = UIImage(named: "Spiral")!
    
}

class CongratViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var head1lbl: UILabel!
    @IBOutlet weak var ayoBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    
    final private let stringWithLink  = "Bagikan Resep"
    final private let image : UIImage = UIImage(named: "Logo App")!
    
    @IBAction func shareBtnTap(_ sender: UIButton) {
        
     

     
        guard let secondActivityItem = URL(string: "https://www.instagram.com/kavi_id/") else { return }

        let activityViewController = UIActivityViewController(
            activityItems: [secondActivityItem],
            applicationActivities: nil
        )
        

        present(activityViewController, animated: true) {
            // ...
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
        
        ayoBtn.layer.cornerRadius = 12
        shareBtn.layer.cornerRadius = 12
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
//        tap.numberOfTapsRequired = 1
//        dismisButton.addGestureRecognizer(tap)
        emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        emitter.emitterCells = generateEmitterCells()
        self.view.layer.addSublayer(emitter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("a")
            self.emitter.lifetime = 0
        }

    }
    
    @objc func close(){
        print("Dismis")
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
    @IBAction func AyoButton(_ sender: UIButton) {
        guard let url = URL(string: "https://wa.me/+6281296940970?text=Hai%20saya%20ingin%20membeli%20Scrub%20Coffe%20Ground%20bisa%20dibantu%20kak?") else { return }
        UIApplication.shared.open(url)
    }

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
    
    //MARK: Particle
    
    var emitter = CAEmitterLayer()
    
    var colors:[UIColor] = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow
    ]
    
    var images:[UIImage] = [
        Images.box,
        Images.triangle,
        Images.circle,
        Images.swirl
    ]
    
    var velocities:[Int] = [
        100,
        90,
        150,
        200
    ]
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16{
            
            let cell = CAEmitterCell()
            
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 1.0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.25
            cell.scale = 0.1
            cells.append(cell)
        }
        
        
        return cells
        
    }
    
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func getNextColor(i:Int) -> CGColor {
        if i <= 4 {
            return colors[0].cgColor
        } else if i <= 8 {
            return colors[1].cgColor
        } else if i <= 12 {
            return colors[2].cgColor
        } else {
            return colors[3].cgColor
        }
    }
    
    private func getNextImage(i:Int) -> CGImage {
        return images[i % 4].cgImage!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
