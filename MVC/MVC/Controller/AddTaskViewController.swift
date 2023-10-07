import UIKit

class AddTaskViewController: UIViewController {

    private var addTaskView = AddTaskView()
    private var tasksListModel: TaskListModel!
    private var taskService: TaskServiceProtocol!
        
    init(tasksListModel: TaskListModel,
         taskService: TaskServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListModel = tasksListModel
        self.taskService = taskService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupAddTaskView()
    }
    
    private func setupAddTaskView() {
        addTaskView.delegate = self
        self.view = addTaskView
    }
}

extension AddTaskViewController: AddTaskViewDelegate {
    
    func addTask(_ task: TaskModel) {
        taskService.saveTask(task, in: tasksListModel)
        dismiss(animated: true)
    }
}
