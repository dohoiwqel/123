//
//  DetailCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
// Дочерний координатор для показа деталей
class MainTabBarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: AuthCoordinator?
    var mainTabBarController: MainTabBarController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.mainTabBarController = MainTabBarController()
        mainTabBarController.coordinator = self
        mainTabBarController.navigationController?.navigationBar.isHidden = true
        navigationController.pushViewController(mainTabBarController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
