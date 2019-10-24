//
//  CoreDataHelper.swift
//  Final Project
//
//  Created by Hai on 23/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper{
    init() {
        
    }
    
    static let managedContext: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    //MARK: - function untuk save data
    
    static func save(){
        do {
            try CoreDataHelper.managedContext.save()
        } catch {
            print("Error")
        }
    }
    
    static func addMaterial(no: Int16, idMaterial: String, nameMaterial: String, descMaterial: String, imageMaterial: UIImage){
        let material = Material(context: CoreDataHelper.managedContext)
        material.no =  no
        material.idMaterial = idMaterial
        material.nameMaterial = nameMaterial
        material.descMaterial = descMaterial
        material.imageMaterial = imageMaterial.jpegData(compressionQuality: 1.0)
        
        CoreDataHelper.save()
//        guard let image = UIImage(na) else { return <#return value#> }
        
    }
    
}
