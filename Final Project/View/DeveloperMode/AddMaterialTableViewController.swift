//
//  AddMaterialTableViewController.swift
//  Final Project
//
//  Created by Hai on 25/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit
import CoreData

class AddMaterialTableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idMaterial: UITextField!
    @IBOutlet weak var nameMaterial: UITextField!
    @IBOutlet weak var descMaterial: UITextField!
    
    var imagePicker: ImagePicker!
    
//    private lazy var dataProvider: DataProvider = {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let provider = DataProvider(with: appDelegate.persistentContainer,
//                                   fetchedResultsControllerDelegate: self)
//        return provider
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

 

    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

}

extension AddMaterialTableViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
extension AddMaterialTableViewController{
    
    @IBAction func saveMaterialButton(_ sender: UIBarButtonItem) {
        let namematerials:String = self.nameMaterial.text!
        let descmaterials:String = self.descMaterial.text!
        var data: Data?
        
        
        MaterialController.addMaterial(name: namematerials, desc: descmaterials)
        let fatchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Material")
        
        do {
            let result = try CoreDataHelper.managedContext.fetch(fatchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "nameMaterial"))
            }
        } catch {
            fatalError()
        }
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true)
    }
    
    func prepareImageForSaving(image:UIImage) {

        // use date as unique id
        let date : Double = NSDate().timeIntervalSince1970

        // dispatch with gcd.
//        DispatchQueue.main.async {
//            
//            // create NSData from UIImage
//            guard let imageData = image.jpegData(compressionQuality: 1) else {
//                // handle failed conversion
//                print("jpg error")
//                return
//            }
//
//            // scale image, I chose the size of the VC because it is easy
//            let thumbnail = image
//
////            guard let thumbnailData  = UIImageJPEGRepresentation(thumbnail, 0.7) else {
////                // handle failed conversion
////                print("jpg error")
////                return
////            }
//
//            // send to save function
//            self.saveImage(imageData, thumbnailData: thumbnailData, date: date)        }
       
    }
}

extension AddMaterialTableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage, let data = image.jpegData(compressionQuality: 1),
            let url = info[.imageURL] as? URL else {
                fatalError("###\(#function): Failed to get JPG data and URL of the picked image!")
        }
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    
}
extension AddMaterialTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
