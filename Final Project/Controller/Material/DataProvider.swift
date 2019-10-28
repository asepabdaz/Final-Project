//
//  DataProvider.swift
//  Final Project
//
//  Created by Hai on 27/10/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum Schema {
    enum Post: String {
        case title, subtitle
    }
    enum Material: String {
        case uuid, name, descmaterial
    }
}

class DataProvider {
    private(set) var persistentContainer: NSPersistentContainer
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
    
    init(with persistentContainer: NSPersistentContainer,
         fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?) {
        self.persistentContainer = persistentContainer
        self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }
    
    /**
     A fetched results controller for the Tag entity, sorted by name.
     */
    lazy var fetchedResultsController: NSFetchedResultsController<Material> = {
        let fetchRequest: NSFetchRequest<Material> = Material.fetchRequest()
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: CoreDataHelper.managedContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("###\(#function): Failed to performFetch: \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
}
