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
    
    static func fetch<T>(entity: String)  -> [T] {
        var result: [T] = []

        let  request =  NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    
        do {
            result = try CoreDataHelper.managedContext.fetch(request) as! [T]
            print("success")
        }
        catch {
            result = []
            print("error")
        }
        return result
    }
    
    
}

enum ContextSaveContextualInfo: String {
    case addPost = "adding a post"
    case deletePost = "deleting a post"
    case batchAddPosts = "adding a batch of post"
    case deduplicate = "deduplicating tags"
    case updatePost = "saving post details"
    case addMaterial = "adding a material"
    case deleteTag = "deleting a tag"
    case addAttachment = "adding an attachment"
    case deleteAttachment = "deleting an attachment"
    case saveFullImage = "saving a full image"
}

extension NSManagedObjectContext{
    
    /**
        Handles save error by presenting an alert.
        */
       private func handleSavingError(_ error: Error, contextualInfo: ContextSaveContextualInfo) {
           print("Context saving error: \(error)")
           
           DispatchQueue.main.async {
               guard let window = UIApplication.shared.delegate?.window,
                   let viewController = window?.rootViewController else { return }
               
               let message = "Failed to save the context when \(contextualInfo.rawValue)."
               
               // Append message to existing alert if present
               if let currentAlert = viewController.presentedViewController as? UIAlertController {
                   currentAlert.message = (currentAlert.message ?? "") + "\n\n\(message)"
                   return
               }
               
               // Otherwise present a new alert
               let alert = UIAlertController(title: "Core Data Saving Error", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               viewController.present(alert, animated: true)
           }
       }
    
    func save(with contextualInfo: ContextSaveContextualInfo) {
        guard hasChanges else { return }
        do {
            try save()
        } catch {
            handleSavingError(error, contextualInfo: contextualInfo)
        }
    }
}
