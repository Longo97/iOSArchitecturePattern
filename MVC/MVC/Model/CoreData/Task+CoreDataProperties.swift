//
//  Task+CoreDataProperties.swift
//  MVC
//
//  Created by Marco Longobardi on 06/10/23.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var done: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var list: TasksList?

}

extension Task : Identifiable {

}
