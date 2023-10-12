//
//  HomeViewModel.swift
//  MVVM
//
//  Created by Marco Longobardi on 12/10/23.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HomeViewModel {
    
    var input: Input!
    var output: Output!
    
    struct Input {
        let reload: PublishRelay<Void>
        let deleteRow: PublishRelay<IndexPath>
        let selectRow: PublishRelay<IndexPath>
    }
    
    struct Output {
        let hideEmptyState: Driver<Bool>
        let lists: Driver<[TaskListModel]>
        let selectedList: Driver<TaskListModel>
    }
    
    private let lists = BehaviorRelay<[TaskListModel]>(value: [])
    private let taskList = BehaviorRelay<TaskListModel>(value: TaskListModel())
    
    private let tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol){
        self.tasksListService = tasksListService
        
        //MARK: Input
        let reload = PublishRelay<Void>()
        _ = reload.subscribe(onNext: { [weak self] _ in
            guard let _self = self else { return }
            _self.fetchTasksLists()
        })
        
        let deleteRow = PublishRelay<IndexPath>()
        _ = deleteRow.subscribe(onNext: { [weak self] indexPath in
            guard let _self = self else { return }
            tasksListService.deleteList(_self.listAtIndexPath(indexPath).id ?? "")
        })
        
        let selectRow = PublishRelay<IndexPath>()
        _ = selectRow.subscribe(onNext: { [weak self] indexPath in
            guard let _self = self else { return }
            _self.taskList.accept(_self.listAtIndexPath(indexPath))
        })
        self.input = Input(reload: reload, deleteRow: deleteRow, selectRow: selectRow)
        
        //MARK: Output
        let items = lists
            .asDriver(onErrorJustReturn: [])
        let hideEmptyState = lists
            .map({ items in
                return !items.isEmpty
            })
            .asDriver(onErrorJustReturn: false)
        
        let selectedList = taskList.asDriver()
        
        output = Output(hideEmptyState: hideEmptyState, lists: items, selectedList: selectedList)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    
    @objc func contextObjectsDidChange() {
        fetchTasksLists()
    }
    
    func fetchTasksLists() {
        lists.accept(tasksListService.fetchLists())
    }
    
    func listAtIndexPath(_ indexPath: IndexPath) -> TaskListModel {
        lists.value[indexPath.row]
    }
}
