import UIKit
import CoreData

/// Keeps references to both the HomeView and the model (The two service protocols)
class HomeViewController: UIViewController {
    
    private var homeView = HomeView()
    
    /// Passing instances of the classes via initializer allows great decoupling (Dependecy Injection)
    private var tasksListService: TasksListServiceProtocol!
    private var taskService: TaskServiceProtocol!

    init(tasksListService: TasksListServiceProtocol, taskService: TaskServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListService = tasksListService
        self.taskService = taskService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Implementation of the Model Observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }

    private func setupHomeView() {
        /// Setup the ViewController as implementation of the delegate
        homeView.delegate = self
        fetchTasksLists()
        self.view = homeView
    }
}

extension HomeViewController {
    
    /// Pass the information to the View for display
    func fetchTasksLists() {
        let lists = tasksListService.fetchLists()
        homeView.setTasksLists(lists)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasksLists()
    }
}


/// Implementation of the Delegate
extension HomeViewController: HomeViewDelegate {
    
    func addListAction() {
        let addListViewController = AddListViewController(tasksListService: tasksListService)
        navigationController?.pushViewController(addListViewController, animated: true)
    }
    
    func selectedList(_ list: TaskListModel) {
        let taskViewController = TaskListViewController(tasksListModel: list, taskService: taskService, tasksListService: tasksListService)
        navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    func deleteList(_ list: TaskListModel) {
        tasksListService.deleteList(list.id ?? "")
    }
}
