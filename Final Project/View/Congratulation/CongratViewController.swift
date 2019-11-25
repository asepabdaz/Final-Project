//
//  CongratViewController.swift
//  Final Project
//
//  Created by Hai on 25/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class CongratViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle")!)
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func close(){
        guard let vc = self.presentingViewController else { return }

        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
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
