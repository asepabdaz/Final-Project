//
//  DeveloperViewController.swift
//  Final Project
//
//  Created by Hai on 22/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class DeveloperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        navigationItem.rightBarButtonItems = [add]
        
    }
    
    @objc func add() {
        print("test")
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cencle", style: .cancel, handler: {_ in
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Add Material", style: .default, handler: {_ in
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Add Product", style: .default, handler: {_ in
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
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
