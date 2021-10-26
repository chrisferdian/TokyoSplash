//
//  AppCoordinator.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow?
    private var mainViewController: MainViewController!
    
    init(window: UIWindow) {
        self.window = window
        self.mainViewController = MainViewController()
        self.navigationController = UINavigationController(rootViewController: self.mainViewController)
        self.navigationController.navigationBar.tintColor = .white
        mainViewController.didNavigateToDetail = { photo in
            self.navigateToDetail(photo: photo)
        }
        mainViewController.didNavigateToSearch = {
            self.navigateToSearch()
        }
    }

    func start() {
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func navigateToDetail(photo: Photo) {
        let detailCoordinator = DetailCoordinator(navigationController: self.navigationController, photo: photo)
        detailCoordinator.start()
    }
    
    func navigateToSearch() {
        let searchCoordinator = SearchCoordinator(navigationController: self.navigationController)
        searchCoordinator.start()
    }
}
