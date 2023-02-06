//
//  Reminder+CoreDataProperties.swift
//  DOGGO
//
//  Created by Lobster on 4.02.23.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID
    @NSManaged public var repeatOption: String?
    @NSManaged public var time: Date?
    @NSManaged public var title: String?

}

extension Reminder : Identifiable {

}
