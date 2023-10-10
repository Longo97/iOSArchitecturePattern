//
//  InMemoryCoreDataManager.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
import CoreData

@testable import MVP

/// Has same functionalities as app's CoreDataManager, but the database in generated in memory and does not persist when the tests are finished
class InMemoryCoreDataManager: CoreDataManager {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: "ToDoList")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}
