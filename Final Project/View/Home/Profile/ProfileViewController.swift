//
//  ProfileViewController.swift
//  Final Project
//
//  Created by Christian Widjaja on 05/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var picture: UIImageView!
        
        let image = UIImagePickerController()

        
        @IBAction func `import`(_ sender: Any) {
     


            image.sourceType = .photoLibrary
            image.allowsEditing = false
            present(image, animated: true, completion: nil)
            picture.contentMode = .scaleAspectFill

            
        }
        
        override func viewDidLoad() {
            picture.layer.borderWidth = 0
            picture.layer.masksToBounds = true
            picture.layer.cornerRadius = picture.frame.height / 2
            picture.clipsToBounds = true
            
            if UserDefaults.standard.object(forKey: "savedImage") as? NSData != nil {
                let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
                
                
                picture.image = UIImage(data: data as Data)
                picture.contentMode = .scaleAspectFill
            }
            
            
            
            super.viewDidLoad()
            image.delegate = self
        
        }
        

    }

    extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
       
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
            info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                picture.image = photo
                
                // Encoding image
                let imageData: NSData = photo.pngData()! as NSData
                UserDefaults.standard.set(imageData, forKey: "savedImage")
            }else if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                picture.image = photo
                let imageData: NSData = photo.pngData()! as NSData
                UserDefaults.standard.set(imageData, forKey: "savedImage")
            }
            dismiss(animated: true, completion: nil)
        }
            
    }
