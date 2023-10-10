//
//  MockTaskService.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
@testable import MVP

class MockTaskService: TaskServiceProtocol {
    private var list: TaskListModel!
    
    required init(coreDataManager: CoreDataManager) {}
    
    convenience init(list: TaskListModel) {
        self.init(coreDataManager: CoreDataManager.shared)
        self.list = list
    }
    
    func saveTask(_ task: TaskModel, in taskList: TaskListModel) {
        list = taskList
        list.tasks?.append(task)
    }
    
    func fetchTasksForList(_ taskList: TaskListModel) -> [TaskModel] {
        return list.tasks ?? [TaskModel]()
    }
    
    func updateTask(_ task: TaskModel) {
        guard let tasks = list.tasks else { return }
        var updatedTasks = [TaskModel]()
        tasks.forEach({
            var updatedTask = $0
            if $0.id == task.id {
                updatedTask.done?.toggle()
            }
            updatedTasks.append(updatedTask)
        })
        list.tasks = updatedTasks
    }
    
    func deleteTask(_ task: TaskModel) {
        list.tasks = list.tasks?.filter({ $0.id != task.id})
    }
}
