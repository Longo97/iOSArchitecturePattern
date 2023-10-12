import UIKit

class AddTaskViewController: UIViewController {

    private var addTaskView: AddTaskView!
    private var tasksListModel: TaskListModel!
        
    init(tasksListModel: TaskListModel) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListModel = tasksListModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupAddTaskView()
    }
    
    private func setupAddTaskView() {
        let viewModel = AddTaskViewModel(tasksListModel: tasksListModel,
                                         taskService: TaskService())
        addTaskView = AddTaskView(viewModel: viewModel)
        addTaskView.delegate = self
        self.view = addTaskView
    }
}

extension AddTaskViewController: AddedTaskViewControllerDelegate {
    
    func addedTask() {
        dismiss(animated: true)
    }
}
