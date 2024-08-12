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
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        if AuthManager.shared.isAuthenticated() {
            self.showDetail()
        } else {
            let vc = AuthViewController()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    func showDetail() {
        detailCoordinator = MainTabBarCoordinator(navigationController: navigationController)
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
