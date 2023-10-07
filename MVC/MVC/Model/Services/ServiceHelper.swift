//
//  ServiceHelper.swift
//  MVC
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
import CoreData

/// This function accept a NSManagedObject and create and execute a fetch request, on a given context and id
public func fetchManagedObjectWithId<T: NSManagedObject>(id: String, context: NSManagedObjectContext) throws -> [T] {
    let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
    fetchRequest.predicate = NSPredicate(format: "id = %@", id)
    return try context.fetch(fetchRequest)
}

/// This function accept a NSManagedObject and create and execute a fetch request, on a given context
public func fetchManagedObject<T: NSManagedObject>(context: NSManagedObjectContext) throws -> [T] {
    let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
    return try context.fetch(fetchRequest)
}
