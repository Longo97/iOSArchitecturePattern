import XCTest

@testable import MVP

class HomePresenterTest: XCTestCase {
    
    var sut: HomePresenter!
    let taskList = TaskListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        let mockTaskListService = MockTaskListService(lists: [taskList])
        sut = HomePresenter(tasksListService: mockTaskListService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testFetchLists_whenAddedOneList_shouldContainModelOneList() {
        sut.fetchTasksLists()
        XCTAssertEqual(sut.numberOfTaskLists, 1)
    }
    
    func testListAtIndex_whenAddedOneList_shouldReturnOneListAtIndexZero() {
        sut.fetchTasksLists()
        XCTAssertNotNil(sut.listAtIndex(0))
    }

    func testRemoveListAtIndex_whenAddedOneList_shouldBeEmptyModelOnDeleteList() {
        sut.fetchTasksLists()
        sut.removeListAtIndex(0)
        XCTAssertEqual(sut.numberOfTaskLists, 0)
    }
}
