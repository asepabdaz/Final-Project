//
//  CongratViewController.swift
//  Final Project
//
//  Created by Hai on 25/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class CongratViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var head1lbl: UILabel!
    @IBOutlet weak var ayoBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    
    final private let stringWithLink  = "Bagikan Resep"
    final private let image : UIImage = UIImage(named: "Logo App")!
    
    @IBAction func shareBtnTap(_ sender: UIButton) {
        
     

     
        let secondActivityItem : NSURL = NSURL(string: "https://www.instagram.com/kavi_id/")!
        let activityController  =  UIActivityViewController(activityItems: [image, secondActivityItem], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error)
            in
            if completed{
                print("Completed")
            }else{
                print("Canceled")
            }
            
        }
        present(activityController, animated: true)
        {
            print("Present")
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

}
