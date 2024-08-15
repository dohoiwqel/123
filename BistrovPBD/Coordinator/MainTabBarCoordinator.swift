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
    var parentCoordinator: AuthCoordinator?
    var childCoordinators: [Coordinator] = []
    var tabBarController: MainTabBarController!
    var profileVC: ProfileViewController!
    var feedVC: FeedViewController!
    var favouritesVC: FavouritesViewController!
    var addTrackVC: AddTrackViewController!
    var playVCIsShowing = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        tabBarController = MainTabBarController()
        tabBarController.coordinator = self
        
        profileVC = ProfileViewController()
        profileVC.coordinator = self
        
        feedVC = FeedViewController()
        feedVC.coordinator = self
        
        favouritesVC = FavouritesViewController()
        favouritesVC.coordinator = self
        
        let profileImage = UIImage(systemName: "person.fill")?.withTintColor(Resources.Colors.basicColor)
        let feedImage = UIImage(systemName: "text.line.first.and.arrowtriangle.forward")?.withTintColor(Resources.Colors.basicColor)
        let favouritesImage = UIImage(systemName: "star.fill")?.withTintColor(Resources.Colors.basicColor)
        
        let profileIcon = UIImage.resizeImage(image: profileImage, targetSize: CGSize(width: 40, height: 40))
        let feedIcon = UIImage.resizeImage(image: feedImage, targetSize: CGSize(width: 40, height: 40))
        let favouritesIcon = UIImage.resizeImage(image: favouritesImage, targetSize: CGSize(width: 40, height: 40))
        
        tabBarController.viewControllers = [
            generateNavController(for: profileVC, title: "Профиль", image: profileIcon),
            generateNavController(for: feedVC, title: "Треки", image: feedIcon),
            generateNavController(for: favouritesVC, title: "Избранные", image: favouritesIcon),
        ]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }

    func generateNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
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
        // Завершение работы координатора, например, возврат к логин-контроллеру
        parentCoordinator?.childDidFinish(self)
        AuthManager.shared.logout()
        parentCoordinator?.start()
    }
    
    func showPlayerViewController(with track: TrackEntities) {
        // Проверяем, есть ли уже PlayerViewController
        if let existingPlayerVC = tabBarController.children.first(where: { $0 is PlayerViewController }) {
            // Удаляем старый PlayerViewController
            existingPlayerVC.willMove(toParent: nil)
            existingPlayerVC.view.removeFromSuperview()
            existingPlayerVC.removeFromParent()
        }
        
        // Создаем новый PlayerViewController
        let playerVC = PlayerViewController()
        playerVC.coodinator = self
        playerVC.configure(with: track)
        
        // Добавляем новый PlayerViewController как дочерний контроллер
        tabBarController.addChild(playerVC)
        tabBarController.view.addSubview(playerVC.view)
        playerVC.didMove(toParent: tabBarController)
        
        // Устанавливаем начальные constraints для плеера
        playerVC.view.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        self.playVCIsShowing = true
        self.tabBarController.view.layoutIfNeeded()
        self.feedVC.reloadTableViewConstraints()
        self.favouritesVC.reloadTableViewConstraints()
    }
    
    func dismissPlayerViewController() {
        AudioPlayerManager.shared.stop()
        if let existingPlayerVC = tabBarController.children.first(where: { $0 is PlayerViewController }) {
            // Удаляем старый PlayerViewController
            existingPlayerVC.willMove(toParent: nil)
            existingPlayerVC.view.removeFromSuperview()
            existingPlayerVC.removeFromParent()
        }
        self.tabBarController.view.layoutIfNeeded()
        self.feedVC.reloadTableViewConstraints()
        self.favouritesVC.reloadTableViewConstraints()
        self.playVCIsShowing = false
        self.feedVC.reloadTableViewConstraints()
        self.favouritesVC.reloadTableViewConstraints()
    }

    func reloadFavourites() {
        guard let favouritesVC = favouritesVC else { return }
        favouritesVC.reloadTracks()
    }
    
    func showAddTrackViewController() {
        addTrackVC = AddTrackViewController()
//        addTrackVC.configure(with: track)
        addTrackVC.maincoodinator = self
        feedVC.present(addTrackVC, animated: true)
    }
    
    func dismissAddTrackViewController() {
        feedVC.dismiss(animated: true)
        feedVC.reloadTracks()
        favouritesVC.reloadTracks()
    }
    
}

