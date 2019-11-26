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
        
     

     
        
        let activityController  =  UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func close(){
        guard let vc = self.presentingViewController else { return }

        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func AyoButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
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
