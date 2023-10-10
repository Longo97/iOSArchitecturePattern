//
//  AddListViewControllerTest.swift
//  MVPTests
//
//  Created by Marco Longobardi on 10/10/23.
//

import Foundation
import XCTest
@testable import MVP

class AddListViewControllerTest: XCTestCase {
    
    var sut: AddListViewController!
    var navigationController: MockNavigationController!
    
    override func setUpWithError() throws {
        sut = AddListViewController()
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }
    
    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testPopVC_whenBackActionIsCalled_thenPopHomeCalled() {
        sut.navigateBack()
        XCTAssert(navigationController.vcIsPopped)
    }
}
