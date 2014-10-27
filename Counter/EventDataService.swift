//
//  File.swift
//  Counter
//
//  Created by Joel Klabo on 10/26/14.
//  Copyright (c) 2014 Joel Klabo. All rights reserved.
//

import Foundation
import CoreData

class EventDataService {
    
    private let dataService = DataService()
    
    func addEvent () {
        var event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: dataService.managedObjectContext!) as Event
        event.date = NSDate()
        dataService.managedObjectContext?.save(nil)
    }
    
    func removeEvent () {
        var events = self.fetchAllEvents()!
        dataService.managedObjectContext?.deleteObject(events.first as NSManagedObject)
    }
    
    func eventCount () -> Int {
        return self.fetchAllEvents()!.count
    }
    
    func clearEvents () {
        for event in self.fetchAllEvents()! {
            dataService.managedObjectContext?.deleteObject(event as NSManagedObject)
        }
    }
    
    func fetchAllEvents () -> [AnyObject]? {
        var fetchRequest = NSFetchRequest()
        let entityName : NSString = "Event"
        var entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: dataService.managedObjectContext!)
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        var events = dataService.managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        return events
    }
}
