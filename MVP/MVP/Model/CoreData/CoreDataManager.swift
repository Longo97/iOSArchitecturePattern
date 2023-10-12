//
//  CoreDataManager.swift
//  MVC
//
//  Created by Marco Longobardi on 06/10/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext(){
        saveContext(self.mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext){
        if context.parent == mainContext {
            saveDerivedContext(context)
            return
        }
        context.perform {
            do {
                try context.save()
            } catch let error as NSError{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveDerivedContext( _ context: NSManagedObjectContext){
        context.perform { [weak self] in
            guard let _self = self else { return }
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Error: \(error.localizedDescription)")
            }
            _self.saveContext(_self.mainContext)
        }
    }
    
    
}
