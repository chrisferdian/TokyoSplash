//
//  DetailsCoordinator.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 25/10/21.
//

import Foundation
import UIKit

class DetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var photo: Photo?
    internal var detailController: DetailsViewController?
    
    init(navigationController: UINavigationController, photo: Photo) {
        self.navigationController = navigationController
        self.photo = photo
    }
    
    func start() {
        self.detailController = DetailsViewController(photo: photo)
        if let controller = self.detailController {
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}
