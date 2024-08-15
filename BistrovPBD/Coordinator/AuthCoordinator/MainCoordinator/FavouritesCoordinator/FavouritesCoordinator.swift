//
//  FavouritesCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit
class FavouritesCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainTabBarCoordinator?
    var favouritesVC: FavouritesViewController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        favouritesVC = FavouritesViewController()
        favouritesVC.coordinator = self
        navigationController.pushViewController(favouritesVC, animated: false)
    }
    
    func reloadData() {
        favouritesVC.reloadTracks()
    }
    
    func reloadTableViewConstraints() {
        favouritesVC.reloadTableViewConstraints()
    }
    
    func showPlayerViewController(with track: TrackEntities) {
        parentCoordinator?.showPlayerViewController(with: track)
    }
    
    func isPlayerShowing() -> Bool {
        return parentCoordinator?.playVCIsShowing ?? false
    }
}
