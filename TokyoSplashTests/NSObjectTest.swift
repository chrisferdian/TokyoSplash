//
//  NSObjectTest.swift
//  TokyoSplashTests
//
//  Created by Chris Ferdian on 24/10/21.
//

import XCTest

class NSObjectTest: XCTestCase {

    var sut: MockViewControllerVM?
    
    override func setUpWithError() throws {
        self.sut = MockViewControllerVM()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func test_className() {
        let className = sut?.className
        XCTAssertEqual(className, "MockViewControllerVM")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
