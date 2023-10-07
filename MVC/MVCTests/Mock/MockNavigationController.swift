//
//  MockNavigationController.swift
//  MVCTests
//
//  Created by Marco Longobardi on 07/10/23.
//

import Foundation
import UIKit

/// Allow to identify when navigation calls have been made in the application
class MockNavigationController: UINavigationController {
    var vcIsPushed: Bool = false
    var vcIsPopped: Bool = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        vcIsPushed = true
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        vcIsPopped = true
        return viewControllers.first
    }
}
