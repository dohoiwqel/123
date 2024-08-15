//
//  ProfileCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit
class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainTabBarCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        navigationController.pushViewController(profileVC, animated: false)
    }
    
    func didFinish() {
        parentCoordinator?.didFinish()
    }
}
