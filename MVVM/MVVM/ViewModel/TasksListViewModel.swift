//
//  TasksListViewModel.swift
//  MVVM
//
//  Created by Marco Longobardi on 12/10/23.
//

import Foundation
import RxRelay
import RxCocoa

class TaskListViewModel {
    
    var output: Output!
    var input: Input!
    
    struct Input {
        let reload: PublishRelay<Void>
        let deleteRow: PublishRelay<IndexPath>
        let updateRow: PublishRelay<IndexPath>
    }
    
    struct Output {
        let hideEmptyState: Driver<Bool>
        let tasks: Driver<[TaskModel]>
        let pageTitle: Driver<String>
    }
    
    private var tasksListModel: TaskListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!
    
    let tasks = BehaviorRelay<[TaskModel]>(value: [])
    let pageTitle = BehaviorRelay<String>(value: "")
    
    init(tasksListModel: TaskListModel,
         taskService: TaskServiceProtocol,
         tasksListService: TasksListServiceProtocol) {
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.tasksListService = tasksListService
        
        // Inputs
        let reload = PublishRelay<Void>()
        _ = reload.subscribe(onNext: { [self] _ in
            fetchTasks()
        })
        let deleteRow = PublishRelay<IndexPath>()
        _ = deleteRow.subscribe(onNext: { [self] indexPath in
            deleteTaskAt(indexPath: indexPath)
        })
        let updateRow = PublishRelay<IndexPath>()
        _ = updateRow.subscribe(onNext: { [self] indexPath in
            updateTaskAt(indexPath: indexPath)
        })
        input = Input(reload: reload, deleteRow: deleteRow, updateRow: updateRow)
        
        // Outputs
        let items = tasks
            .asDriver(onErrorJustReturn: [])
        let hideEmptyState = tasks
            .map({ items in
                return !items.isEmpty
            })
            .asDriver(onErrorJustReturn: false)
        let pageTitle = pageTitle
            .asDriver(onErrorJustReturn: "")
        output = Output(hideEmptyState: hideEmptyState, tasks: items, pageTitle: pageTitle)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasks()
    }
    
    func fetchTasks() {
        guard let list = tasksListService.fetchListWithId(tasksListModel.id ?? "") else { return }
        pageTitle.accept(list.title ?? "")
        guard let tasks = list.tasks else { return }
        let orderedTasks = tasks.sorted(by: { $0.createdAt?.compare($1.createdAt ?? Date()) == .orderedDescending })
        self.tasks.accept(orderedTasks)
    }
    
    func deleteTaskAt(indexPath: IndexPath) {
        taskService.deleteTask(tasks.value[indexPath.row])
    }
    
    func updateTaskAt(indexPath: IndexPath) {
        var taskToUpdate = tasks.value[indexPath.row]
        taskToUpdate.done?.toggle()
        taskService.updateTask(taskToUpdate)
    }
}
