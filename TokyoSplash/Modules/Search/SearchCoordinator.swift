//
//  SearchCoordinator.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 26/10/21.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var didChildHasFinish : (() -> ())?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = SearchViewController()
        self.navigationController.pushViewController(controller, animated: true)
    }
}
