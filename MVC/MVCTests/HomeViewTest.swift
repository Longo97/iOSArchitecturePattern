//
//  HomeViewTest.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import XCTest
/// Make visible the project to test it
@testable import MVC

final class HomeViewTest: XCTestCase {
    
    /// sut = System Under Test
    var sut: HomeView!

    /// This method is called before the invocation of each test method in the class.
    override func setUpWithError() throws {
        sut = HomeView()
    }

    /// This method is called after the invocation of each test method in the class.
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    /// Must start with "test" to detect it as a test.
    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.addListButton)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.emptyState)
    }
}
