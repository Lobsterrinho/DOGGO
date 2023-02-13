//
//  ToDoTask+CoreDataProperties.swift
//  DOGGO
//
//  Created by Lobster on 11.02.23.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var taskType: String?
    @NSManaged public var id: UUID?
    @NSManaged public var status: Bool

}

extension ToDoTask : Identifiable {

}
