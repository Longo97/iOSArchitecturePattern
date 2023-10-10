import XCTest

@testable import MVP

class AddTaskPresenterTest: XCTestCase {
    
    var sut: AddTaskPresenter!

    override func setUpWithError() throws {
        let taskList = TaskListModel(id: "12345-67890",
                                      title: "Test List",
                                      icon: "test.icon",
                                      tasks: [TaskModel](),
                                      createdAt: Date())
        let mockTaskService = MockTaskService(list: taskList)
        sut = AddTaskPresenter(tasksListModel: taskList, taskService: mockTaskService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddIcon_whenAddedIcon_shouldContainObjectIcon() {
        sut.setTaskIcon("test.icon")
        XCTAssertEqual(sut.task.icon, "test.icon")
    }
    
    func testAddTitle_whenAddedTitle_shouldContainObjectTitle() {
        sut.addTaskWithTitle("Test Task")
        XCTAssertEqual(sut.task.title, "Test Task")
    }
}
