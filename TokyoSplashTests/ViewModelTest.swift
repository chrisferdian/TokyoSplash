//
//  ViewModelTest.swift
//  TokyoSplashTests
//
//  Created by Chris Ferdian on 24/10/21.
//

import XCTest
@testable import TokyoSplash

class ViewModelTest: XCTestCase {

    var viewController: MockViewControllerVM!
    var viewModel: MockViewModel!
    
    override func setUpWithError() throws {
        self.viewModel = MockViewModel()
        self.viewController = MockViewControllerVM()
        self.viewController.viewModel = self.viewModel
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        self.viewController = nil
    }

    func test_bindData() {
        viewModel.bindPhotos = {
            self.viewController.dataChanged = true
            XCTAssertTrue(self.viewController.dataChanged)
        }
        self.viewModel.appendNewPhoto()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
class MockViewModel: MainViewModel {
    func appendNewPhoto() {
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
        photos = [tempPhoto]
    }
}

class MockViewControllerVM: UIViewController {
    
    var viewModel: MainViewModel?
    var dataChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.bindPhotos = {
            self.dataChanged = true
        }
    }
}
