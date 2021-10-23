//
//  TokyoSplashTests.swift
//  TokyoSplashTests
//
//  Created by Chris Ferdian on 23/10/21.
//

import XCTest
@testable import TokyoSplash
typealias Photos = [mockModel]

class mockModel: Codable {
    let id: String?
}
class TokyoSplashTests: XCTestCase {

    var service: NetworkServices?
    
    override func setUpWithError() throws {
        self.service = NetworkServices.shared
    }

    override func tearDownWithError() throws {
        self.service = nil
    }

    func test_ListPhotosAPI() throws {
        let expectation = XCTestExpectation(description: "ListPhotosAPI")
        
        self.service?.request(request: .listPhotos(page: 1), completion: { (result: Result<(mockModel?, [mockModel]?), Error>) in
            switch result {
            case .success(let value):
                print(value)
                XCTAssertNotNil(value)
                XCTAssertEqual(value.1?.count, 10)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTAssertThrowsError(error)
            }
        })
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
