//
//  TasksCoreDataService.swift
//  DOGGO
//
//  Created by Lobster on 10.02.23.
//

import CoreData

final class TasksCoreDataService {
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TasksCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

