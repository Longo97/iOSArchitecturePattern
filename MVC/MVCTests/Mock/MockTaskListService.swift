//
//  MockTaskListService.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
@testable import MVP

class MockTaskListService: TasksListServiceProtocol {
    
    private var lists: [TaskListModel] = [TaskListModel]()
    
    required init(coreDataManager: CoreDataManager) {}
    
    convenience init(lists: [TaskListModel]) {
        self.init(coreDataManager: CoreDataManager.shared)
        self.lists = lists
    }
    
    func saveTasksList(_ list: TaskListModel) {
        lists.append(list)
    }
    
    func fetchLists() -> [TaskListModel] {
        return lists
    }
    
    func fetchListWithId(_ id: String) -> TaskListModel? {
        return lists.filter({ $0.id == id}).first
    }
    
    func deleteList(_ id: String) {
        lists = lists.filter({ $0.id != id})
    }
    
}
