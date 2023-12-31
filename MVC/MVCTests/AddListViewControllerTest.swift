import XCTest

@testable import MVC

class AddListViewControllerTest: XCTestCase {
    
    var sut: AddListViewController!
    var navigationController: MockNavigationController!
    var tasksListService: MockTaskListService!
    let list = TaskListModel(id: ProcessInfo().globallyUniqueString,
                              title: "Test title",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())

    override func setUpWithError() throws {
        tasksListService = MockTaskListService(lists: [TaskListModel]())
        sut = AddListViewController(tasksListService: tasksListService)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        tasksListService = nil
        super.tearDown()
    }

    func testListAddition_whenAddedAList_shouldBeOneOnDatabase() {
        sut.addList(list)
        XCTAssertEqual(tasksListService.fetchLists().count, 1)
    }
    
    func testPopVC_whenAddListIsCalled_thenPopHomeCalled() {
        sut.addList(list)
        XCTAssertTrue(navigationController.vcIsPopped)
    }
    
    func testPopVC_whenBackActionIsCalled_thenPopHomeCalled() {
        sut.navigateBack()
        XCTAssertTrue(navigationController.vcIsPopped)
    }
}
