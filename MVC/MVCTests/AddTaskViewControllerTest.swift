import XCTest

@testable import MVC

class AddTaskViewControllerTest: XCTestCase {
    
    
    var sut: AddTaskViewController!
    var taskService: MockTaskService!
    var navigationController: MockNavigationController!
    let list = TaskListModel(id: ProcessInfo().globallyUniqueString,
                              title: "Test title",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())
    let task = TaskModel(id: ProcessInfo().globallyUniqueString,
                         title: "Task",
                         icon: "test.icon",
                         done: true,
                         createdAt: Date())
    
    override func setUpWithError() throws {
        taskService = MockTaskService(list: list)
        sut = AddTaskViewController(tasksListModel: list, taskService: taskService)
    }

    override func tearDownWithError() throws {
        sut = nil
        taskService = nil
        super.tearDown()
    }

    func testAddTask_whenAddedATask_shouldBeOneOnDatabase() {
        sut.addTask(task)
        XCTAssertEqual(taskService.fetchTasksForList(list).count, 1)
    }
}
