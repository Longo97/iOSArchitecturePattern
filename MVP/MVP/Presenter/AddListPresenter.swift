//
//  AddListPresenter.swift
//  MVP
//
//  Created by Marco Longobardi on 10/10/23.
//

import Foundation

class AddListPresenter {
    private weak var addListView: AddListViewDelegate?
    private var tasksListService: TasksListServiceProtocol!
    var list: TaskListModel!
    
    init(addListView: AddListViewDelegate? = nil, tasksListService: TasksListServiceProtocol) {
        self.addListView = addListView
        self.tasksListService = tasksListService
        self.list = TaskListModel(id: ProcessInfo().globallyUniqueString, icon: "checkmark.seal.fill", createdAt: Date())
    }
    
    func setIconList(_ icon: String){
        list.icon = icon
    }
    
    func addListWithTitle(_ title: String) {
        list.title = title
        tasksListService.saveTasksList(list)
        addListView?.backToHome()
    }
}
