//
//  TaskModel.swift
//  MVC
//
//  Created by Marco Longobardi on 06/10/23.
//

import Foundation
import CoreData

struct TaskModel{
    var id: String?
    var title: String?
    var icon: String?
    var done: Bool?
    var createdAt: Date?
}

extension TaskModel: EntityModelMapProtocol{
    typealias EntityType = Task
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let task: Task = .init(context: context)
        task.id = id
        task.title = title
        task.icon = icon
        task.done = done ?? false
        task.createdAt = createdAt
        return task
    }
    
    static func mapFromEntity(_ entity: Task) -> Self {
        return .init(id: entity.id, title: entity.title, icon: entity.icon, done: entity.done, createdAt: entity.createdAt)
    }
    
}
