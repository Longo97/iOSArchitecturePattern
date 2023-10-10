import UIKit

class AddListViewController: UIViewController, AddListViewDelegate {

    private var addListView = AddListView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func loadView() {
        super.loadView()
        setupAddListView()
    }
    
    private func setupAddListView() {
        let presenter = AddListPresenter(addListView: addListView, tasksListService: TasksListService())
        addListView.delegate = self
        addListView.presenter = presenter
        self.view = addListView
    }
    
    
    internal func backToHome() {
        navigationController?.popViewController(animated: true)
    }
}


extension AddListViewController: BackButtonDelegate {
    
    func navigateBack() {
        backToHome()
    }
}
