//
//  DataService.swift
//  Counter
//
//  Created by Joel Klabo on 10/26/14.
//  Copyright (c) 2014 Joel Klabo. All rights reserved.
//

import Foundation
import CoreData

class DataService {
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count - 1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        if let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd") {
            return NSManagedObjectModel(contentsOfURL: modelURL)
        } else {
            println("Error: can't create managed object model")
            return nil
        }
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        if let managedObjectModel = self.managedObjectModel {
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Counter.sqlite")
            
            var error: NSError? = nil
            
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options, error: &error)
            
            
            if let error = error {
                println("Error: Can't add persistent store type to persistent store coordinate")
                return nil
            } else {
                return coordinator
            }
        } else {
            println("Error: Can't create persistant store coordinator. Because managed object model is not valid.")
            return nil
        }
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        if let coordinator = self.persistentStoreCoordinator {
            let managedObjectContext = NSManagedObjectContext()
            managedObjectContext.persistentStoreCoordinator = coordinator
            
            return managedObjectContext
        } else {
            println("Error: Can't create managed object context. Persistent store coordinator is not valid")
            return nil
        }
    }()
    
}
