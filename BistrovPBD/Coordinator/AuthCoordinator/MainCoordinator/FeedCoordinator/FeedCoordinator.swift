//
//  FeedCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit
class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainTabBarCoordinator?
    var feedVC: FeedViewController!
    var addTrackVC: AddTrackViewController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.pushViewController(feedVC, animated: false)
    }

    func showAddTrackViewController() {
        addTrackVC = AddTrackViewController()
        addTrackVC.coordinator = self
        navigationController.present(addTrackVC, animated: true)
    }
    
    func dismissAddTrackViewController() {
        feedVC.dismiss(animated: true)
        
        //reloadTasks
        parentCoordinator?.reloadData()
        
    }
    
    func reloadData() {
        feedVC.reloadTracks()
    }
    
    func reloadTableViewConstraints() {
        feedVC.reloadTableViewConstraints()
    }
    
    func showPlayerViewController(with track: TrackEntities) {
        parentCoordinator?.showPlayerViewController(with: track)
    }
    
    func isPlayerShowing() -> Bool {
        return parentCoordinator?.playVCIsShowing ?? false
    }
}

