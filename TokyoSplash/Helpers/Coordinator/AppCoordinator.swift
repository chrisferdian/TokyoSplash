//
//  AppCoordinator.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var window: UIWindow?
    private var mainViewController: MainViewController!
    
    init(window: UIWindow) {
        self.window = window
        self.mainViewController = MainViewController()
        self.navigationController = UINavigationController(rootViewController: self.mainViewController)
        self.navigationController.navigationBar.tintColor = .white
    }

    func start() {
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}
