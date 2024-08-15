//
//  AuthCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
// Главный координатор
class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [] // Массив для хранения дочерних координаторов
    var detailCoordinator: MainTabBarCoordinator!
    var authViewController: AuthViewController!
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        if AuthManager.shared.isAuthenticated() {
            self.showMain()
        } else {
            self.showAuth()
        }
    }
    
    public func showAuth() {
        print("coordinators: \(childCoordinators)")
        authViewController = AuthViewController()
        authViewController.coordinator = self
        navigationController.pushViewController(authViewController, animated: false)
    }
    
    func showMain() {
        detailCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator) // Добавляем дочерний координатор в массив
        detailCoordinator.start() // Запускаем дочерний координатор
    }
    
    func childDidFinish(_ child: Coordinator?) {
        // Удаляем дочерний координатор из массива, когда он завершает свою работу
        guard let child = child else { return }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
