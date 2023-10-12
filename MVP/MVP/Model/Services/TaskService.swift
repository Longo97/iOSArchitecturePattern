//
//  TaskService.swift
//  MVC
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
import CoreData

protocol TaskServiceProtocol: AnyObject{
    init(coreDataManager: CoreDataManager)
    func saveTask(_ task: TaskModel, in taskList: TaskListModel)
    func fetchTasksForList(_ taskList: TaskListModel) -> [TaskModel]
    func updateTask(_ task: TaskModel)
    func deleteTask(_ task: TaskModel)
}

class TaskService: TaskServiceProtocol{
    
    let context: NSManagedObjectContext
    let coreDataManager: CoreDataManager
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func saveTask(_ task: TaskModel, in taskList: TaskListModel) {
        do {
            guard let list: TasksList = try fetchManagedObjectWithId(id: taskList.id ?? "", context: context).first else {
                return
            }
            let taskEntity = task.mapToEntityInContext(context)
            list.addToTasks(taskEntity)
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("Core Data Error")
        }
    }
    
    func fetchTasksForList(_ taskList: TaskListModel) -> [TaskModel] {
        var tasks = [TaskModel]()
        do {
            guard let list: TasksList = try fetchManagedObjectWithId(id: taskList.id ?? "", context: context).first, 
                    let taskEntities = list.tasks else {
                return tasks
            }
            tasks = taskEntities.map({
                TaskModel.mapFromEntity($0 as! Task)
            })
        } catch {
            debugPrint("Core Data Error")
        }
        return tasks
    }
    
    func updateTask(_ task: TaskModel) {
        do {
            guard let taskEntity: Task = try fetchManagedObjectWithId(id: task.id ?? "", context: context).first else {
                return
            }
            taskEntity.done = task.done ?? false
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("Core Data Error")
        }
    }
    
    func deleteTask(_ task: TaskModel) {
        do {
            let taskEntities: [Task] = try fetchManagedObjectWithId(id: task.id ?? "", context: context)
            for taskEntity in taskEntities {
                context.delete(taskEntity)
            }
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("Core Data Error")
        }
    }
}
