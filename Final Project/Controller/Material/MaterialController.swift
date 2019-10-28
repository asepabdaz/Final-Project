//
//  MaterialController.swift
//  Final Project
//
//  Created by Hai on 27/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit
import CoreData

class MaterialController{

    
//    lazy var fetchResultController: NSFetchedResultsController<Material> = {
//        let fetchRequest: NSFetchRequest<Material> = Material.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Schema.Material.name.rawValue, ascending: false)]
//        
//        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        
//        controller.delegate = fetchResultControllerDelegate
//        
//        do{
//            try controller.performFetch()
//        }catch{
//            let nserror = error as NSError
//            fatalError("\(nserror.userInfo)")
//        }
//        return controller
//    }()
    
    
    static func addMaterial(name: String, desc: String, image:Data? = nil ) {
        
        
        
        let material = Material(context: CoreDataHelper.managedContext)
        material.nameMaterial = name
        material.descMaterial = desc
        material.uuid = UUID()
        material.image = image
            
        CoreDataHelper.save()
    }
}
