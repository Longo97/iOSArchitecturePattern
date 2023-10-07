//
//  TasksListServiceTest.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import XCTest
@testable import MVC

final class TasksListServiceTest: XCTestCase {
    var sut: TasksListServiceProtocol!
    var list: TaskListModel!
    
    override func setUpWithError() throws {
        sut = TasksListService(coreDataManager: InMemoryCoreDataManager())
        list = TaskListModel(id: "12345-67890", title: "Test List", icon: "test.icon", tasks: [TaskModel](), createdAt: Date())
    }
    
    override func tearDownWithError() throws {
        sut = nil
        list = nil
        super.tearDown()
    }
    
    func testSaveOnDB_whenSavesAList_shouldBeOneOnDatabase() throws {
        sut.saveTasksList(list)
        XCTAssertEqual(sut.fetchLists().count, 1)
    }
    
    func testSaveOnDB_whenSavesAList_shouldBeOneWithGivenIdOnDatabase() throws {
        sut.saveTasksList(list)
        XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
    }
    
    func testDeleteOnDB_whenSavesAListAndThenDeleted_shouldBeNoneOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
        sut.deleteList(list.id ?? "12345-67890")
        XCTAssertEqual(sut.fetchLists().count, 0)
    }
    
}
