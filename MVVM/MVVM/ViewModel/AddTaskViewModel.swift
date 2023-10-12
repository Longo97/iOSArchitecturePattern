//
//  AddTaskViewModel.swift
//  MVVM
//
//  Created by Marco Longobardi on 12/10/23.
//

import Foundation
import RxRelay
import RxCocoa

class AddTaskViewModel {
    
    var output: Output!
    var input: Input!
    
    struct Input {
        let icon: PublishRelay<String>
        let title: PublishRelay<String>
        let addTask: PublishRelay<Void>
    }
    
    struct Output {
        let dismiss: Driver<Void>
    }

    private var tasksListModel: TaskListModel!
    private var taskService: TaskServiceProtocol!
    private(set) var task: TaskModel!
    
    let dismiss = BehaviorRelay<Void>(value: ())

    init(tasksListModel: TaskListModel,
         taskService: TaskServiceProtocol) {
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.task = TaskModel(id: ProcessInfo().globallyUniqueString,
                              icon: "checkmark.seal.fill",
                              done: false,
                              createdAt: Date())
        
        // Inputs
        let icon = PublishRelay<String>()
        _ = icon.subscribe(onNext: { [self] newIcon in
            task.icon = newIcon
        })
        let title = PublishRelay<String>()
        _ = title.subscribe(onNext: { [self] newTitle in
            task.title = newTitle
        })
        let addTask = PublishRelay<Void>()
        _ = addTask.subscribe(onNext: { [self] _ in
            taskService.saveTask(task, in: tasksListModel)
            dismiss.accept(())
        })
        input = Input(icon: icon, title: title, addTask: addTask)
        
        // Outputs
        let dismissView = dismiss.asDriver()
        output = Output(dismiss: dismissView)
    }
}
