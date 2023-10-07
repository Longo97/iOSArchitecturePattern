//
//  TasksListService.swift
//  MVC
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
import CoreData

protocol TasksListServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func saveTasksList(_ list: TaskListModel)
    func fetchLists() -> [TaskListModel]
    func fetchListWithId(_ id: String) -> TaskListModel?
    func deleteList(_ id: String)
}

class TasksListService: TasksListServiceProtocol {
    let context: NSManagedObjectContext
    let coreDataManager: CoreDataManager
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func saveTasksList(_ list: TaskListModel) {
        _ = list.mapToEntityInContext(context)
        coreDataManager.saveContext(context)
    }
    
    func fetchLists() -> [TaskListModel] {
        var lists = [TaskListModel]()
        do{
            let value: [TasksList] = try fetchManagedObject(context: context)
            lists = value.map({
                TaskListModel.mapFromEntity($0)
            })
            lists = lists.sorted(by: {$0.createdAt?.compare($1.createdAt ?? Date()) == .orderedDescending})
        } catch {
            debugPrint("CoreData Error")
        }
        
        return lists
    }
    
    func fetchListWithId(_ id: String) -> TaskListModel? {
        do{
            let listEntities: [TasksList] = try fetchManagedObjectWithId(id: id, context: context)
            guard let list = listEntities.first else {
                return nil
            }
            return TaskListModel.mapFromEntity(list)
        } catch {
            debugPrint("Core Data Error")
            return nil
        }
    }
    
    func deleteList(_ id: String) {
        do{
            let listEntities: [TasksList] = try fetchManagedObjectWithId(id: id, context: context)
            for listEntity in listEntities {
                context.delete(listEntity)
            }
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("Core Data Error")
        }
    }
    
    
}
