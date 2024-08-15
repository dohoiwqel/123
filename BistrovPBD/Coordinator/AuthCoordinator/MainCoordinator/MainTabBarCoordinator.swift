//
//  DetailCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
class MainTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: AuthCoordinator?
    var childCoordinators: [Coordinator] = []
    var profileCoordinator: ProfileCoordinator!
    var feedCoordinator: FeedCoordinator!
    var favouritesCoordinator: FavouritesCoordinator!
    var playerCoordinator: PlayerCoordinator!
    
    var tabBarController: MainTabBarController!
    var playVCIsShowing = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }

    func start() {
        playerCoordinator = PlayerCoordinator(navigationController: UINavigationController())
        playerCoordinator.parentCoordinator = self
        
        tabBarController = MainTabBarController()
        tabBarController.coordinator = self
        
        profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        profileCoordinator.parentCoordinator = self
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()

        feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        feedCoordinator.parentCoordinator = self
        childCoordinators.append(feedCoordinator)
        feedCoordinator.start()
        
        favouritesCoordinator = FavouritesCoordinator(navigationController: UINavigationController())
        favouritesCoordinator.parentCoordinator = self
        childCoordinators.append(favouritesCoordinator)
        favouritesCoordinator.start()
        let profileImage = UIImage(systemName: "person.fill")?.withTintColor(Resources.Colors.basicColor)
        let feedImage = UIImage(systemName: "text.line.first.and.arrowtriangle.forward")?.withTintColor(Resources.Colors.basicColor)
        let favouritesImage = UIImage(systemName: "star.fill")?.withTintColor(Resources.Colors.basicColor)

        let profileIcon = UIImage.resizeImage(image: profileImage, targetSize: CGSize(width: 40, height: 40))
        let feedIcon = UIImage.resizeImage(image: feedImage, targetSize: CGSize(width: 40, height: 40))
        let favouritesIcon = UIImage.resizeImage(image: favouritesImage, targetSize: CGSize(width: 40, height: 40))

        tabBarController.viewControllers = [
                generateNavController(for: profileCoordinator.navigationController, title: "Профиль", image: profileIcon),
                generateNavController(for: feedCoordinator.navigationController, title: "Треки", image: feedIcon),
                generateNavController(for: favouritesCoordinator.navigationController, title: "Избранные", image: favouritesIcon),
            ]
    
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func generateNavController(for navController: UINavigationController, title: String, image: UIImage?) -> UINavigationController {
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        // Устанавливаем отступы для изображения, чтобы сдвинуть его вверх
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: -6, left: 0, bottom: 6, right: 0)

        // Устанавливаем смещение для текста, чтобы сдвинуть его вниз
        navController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)

        navController.navigationBar.isHidden = true
        return navController
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        AuthManager.shared.logout()
        parentCoordinator?.start()
    }
    
    func showPlayerViewController(with track: TrackEntities) {
        playerCoordinator.track = track
        playerCoordinator.start()
    }

    func dismissPlayerViewController() {
        playerCoordinator.removePlayerViewController()
    }

    
    
    func reloadConstraints() {
        favouritesCoordinator.reloadTableViewConstraints()
        feedCoordinator.reloadTableViewConstraints()
    }
    
    func reloadData() {
        favouritesCoordinator.reloadData()
        feedCoordinator.reloadData()
    }
    
}
