//
//  DeveloperMode.swift
//  Final Project
//
//  Created by Hai on 24/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import Foundation
import UIKit

class DeveloperMode: UITableViewController {
    
    
    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
 
    }
    
    
    
}
extension DeveloperMode{
    @IBAction func AddAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Add Material", style: .default, handler: { _ in
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "Material", sender: self)
            
        }))
        present(alert, animated: true)
    }
    @IBAction func reset(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    @IBAction func saveProduct(_ sender: UIBarButtonItem) {
        
    }
}
