//
//  HomePresenter.swift
//  MVP
//
//  Created by Marco Longobardi on 10/10/23.
//

import Foundation

class HomePresenter{
    private weak var homeView: HomeViewDelegate?
    private var tasksListService: TasksListServiceProtocol!
    private var lists: [TaskListModel] = [TaskListModel]()
    
    init(homeView: HomeViewDelegate? = nil, tasksListService: TasksListServiceProtocol) {
        self.homeView = homeView
        self.tasksListService = tasksListService
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectDidChange(){
        fetchTasksLists()
    }
    
    func fetchTasksLists(){
        lists = tasksListService.fetchLists()
        homeView?.reloadData()
    }
    
    var numberOfTaskLists: Int{
        return lists.count
    }
    
    func listAtIndex(_ index: Int) -> TaskListModel{
        return lists[index]
    }
    
    func removeListAtIndex(_ index: Int) {
        let list = listAtIndex(index)
        tasksListService.deleteList(list.id ?? "")
        lists.remove(at: index)
    }
}
