//
//  NavigationParsingDataTest.swift
//  TokyoSplashTests
//
//  Created by Chris Ferdian on 25/10/21.
//

import XCTest
@testable import TokyoSplash

class NavigationParsingDataTest: XCTestCase {

    var sut: DetailsViewController?
    
    override func setUpWithError() throws {
        let urlsMock = Urls(raw: "", full: "", regular: "", small: "", thumb: "")
        let tempPhoto = Photo(
            id: "123",
            createdAt: nil,
            updatedAt: nil,
            promotedAt: nil,
            width: 300,
            height: 300,
            color: nil,
            blurHash: nil,
            photoDescription: "MockPhotoObject",
            altDescription: nil,
            urls: urlsMock,
            links: nil,
            categories: nil,
            likes: 1000,
            likedByUser: true,
            sponsorship: nil,
            topicSubmissions: nil,
            user: nil
        )
        sut = DetailsViewController(photo: tempPhoto)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_CheckPhotoNotNil() throws {
        XCTAssertNotNil(sut?.photo)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
