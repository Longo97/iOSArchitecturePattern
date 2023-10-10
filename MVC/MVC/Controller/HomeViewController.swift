import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    private var homeView = HomeView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }
    

    private func setupHomeView() {
        let presenter = HomePresenter(homeView: homeView, tasksListService: TasksListService())
        homeView.delegate = self
        homeView.presenter = presenter
        homeView.setupView()
        self.view = homeView
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    
    func addList(){
        navigationController?.pushViewController(AddListViewController(), animated: true)
    }
    
    func selectedList(_ list: TaskListModel){
        let taskViewController = TaskListViewController(tasksListModel: list)
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}
