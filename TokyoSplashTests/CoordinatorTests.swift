//
//  CoordinatorTests.swift
//  TokyoSplashTests
//
//  Created by Chris Ferdian on 23/10/21.
//

import XCTest
@testable import TokyoSplash

class CoordinatorTests: XCTestCase {
    private var sut: UIViewController!
    private var coordinator: CoordinatorMock!
    private var navigationController: UINavigationController!
    var window: UIWindow!

    override func setUpWithError() throws {
        window = UIWindow(frame: UIScreen.main.bounds)
        sut = UIViewController()
        self.navigationController = UINavigationController(rootViewController: sut)
        _ = navigationController.view
        coordinator = CoordinatorMock(navigationController: navigationController)
        window.makeKeyAndVisible()
        window.rootViewController = self.navigationController

    }

    override func tearDownWithError() throws {
        self.navigationController = nil
        self.sut = nil
        self.coordinator = nil
        self.window = nil
    }

    func test_push_child() throws {
        XCTAssertNotNil(sut)
        XCTAssertEqual(navigationController.viewControllers.first, sut)
    }
    
    func test_navigation_to_child() throws {
        let expectation = XCTestExpectation(description: "ListPhotosAPI")
        coordinator.start()
        XCTAssertTrue(coordinator.childCoordinators.count == 1)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
//MARK: Mock ViewController
class ViewControllerMock: UIViewController {}
class ChildViewControllerMock: UIViewController {}

//MARK: Mock class
final class CoordinatorMock: Coordinator {
    var parent: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewControllerMock()
        self.navigationController.pushViewController(viewController, animated: true)
        childCoordinators.append(self)
    }
}
