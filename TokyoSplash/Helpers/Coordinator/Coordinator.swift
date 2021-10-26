//
//  Coordinator.swift
//  TokyoSplash
//
//  Created by Chris Ferdian on 23/10/21.
//

import UIKit
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
