//
//  HomeViewControllerTest.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import XCTest
@testable import MVC

final class HomeViewControllerTest: XCTestCase {
    var sut: HomeViewController!
    var navigationController: MockNavigationController!
    var tasksListService: MockTaskListService!
    var taskService: MockTaskService!
    let list = TaskListModel(id: ProcessInfo().globallyUniqueString, title: "Test title", icon: "test.icon", tasks: [TaskModel](), createdAt: Date())

    override func setUpWithError() throws {
        tasksListService = MockTaskListService(lists: [list])
        taskService = MockTaskService(coreDataManager: InMemoryCoreDataManager())
        sut = HomeViewController(tasksListService: tasksListService, taskService: taskService)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        taskService = nil
        super.tearDown()
    }

    func testDeleteList_whenDeletedActionIsCalled_shouldBeNoneOnDatabase() {
            sut.deleteList(list)
            XCTAssertEqual(tasksListService.fetchLists().count, 0)
        }
        
        func testPushVC_whenAddListIsCalled_thenPushAddListVCCalled() {
            sut.addListAction()
            XCTAssertTrue(navigationController.vcIsPushed)
        }
        
        func testPushVC_whenTaskListIsCalled_thenPushTaskListVCCalled() {
            sut.selectedList(TaskListModel())
            XCTAssertTrue(navigationController.vcIsPushed)
        }

}
