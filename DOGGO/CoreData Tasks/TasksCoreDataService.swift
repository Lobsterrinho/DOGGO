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
    
    static func fetchController(date: Date) {
        let context = self.context
        let fetchRequest = ToDoTask.fetchRequest()
        let startDate = Calendar.current.startOfDay(for: date)
        var components = DateComponents()
               components.day = 1
               components.second = -1
        let endDate = Calendar.current.date(byAdding: components, to: startDate)!
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(ToDoTask.date)) >= %@ AND \(#keyPath(ToDoTask.date)) <= %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "\(#keyPath(ToDoTask.date))", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
    
}

