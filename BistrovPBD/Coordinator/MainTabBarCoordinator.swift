//
//  DetailCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
// Дочерний координатор для показа деталей
import UIKit

class MainTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: AuthCoordinator?
    var childCoordinators: [Coordinator] = []
    var tabBarController: MainTabBarController!
    var profileVC: ProfileViewController!
    var feedVC: FeedViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        tabBarController = MainTabBarController()
        tabBarController.coordinator = self
        
        // Здесь вы можете настроить другие контроллеры и передать координатор в них
        profileVC = ProfileViewController()
        profileVC.coordinator = self
        
        feedVC = FeedViewController()
        
        tabBarController.viewControllers = [
            generateNavController(for: profileVC, title: "Профиль", image: UIImage(named: "profile.pdf")),
            generateNavController(for: feedVC, title: "Лента", image: UIImage(named: "feed.pdf"))
        ]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func generateNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.isHidden = true
        return navController
    }
    
    func didFinish() {
        // Завершение работы координатора, например, возврат к логин-контроллеру
        parentCoordinator?.childDidFinish(self)
        AuthManager.shared.logout()
        parentCoordinator?.start()
    }
}

