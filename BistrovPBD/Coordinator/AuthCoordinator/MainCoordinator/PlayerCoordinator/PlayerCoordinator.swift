//
//  PlayerCoordinator.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit
class PlayerCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainTabBarCoordinator?
    var playerVC: PlayerViewController?
    var track: TrackEntities!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let _ = playerVC {
            removePlayerViewController()
        }

        // Создаем новый PlayerViewController
        let playerVC = PlayerViewController()
        playerVC.coodinator = self
        playerVC.configure(with: track)
        self.playerVC = playerVC

        // Добавляем новый PlayerViewController как дочерний контроллер
        parentCoordinator?.navigationController.addChild(playerVC)
        parentCoordinator?.navigationController.view.addSubview(playerVC.view)
        playerVC.didMove(toParent: parentCoordinator?.navigationController)

        // Устанавливаем начальные constraints для плеера
        playerVC.view.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        parentCoordinator?.navigationController.view.layoutIfNeeded()
        parentCoordinator?.playVCIsShowing = true
        parentCoordinator?.reloadConstraints()
    }
    
    func reloadData() {
        parentCoordinator?.reloadData()
    }
    
    func reloadConstraints() {
        parentCoordinator?.reloadConstraints()
    }
    

    func removePlayerViewController() {
        AudioPlayerManager.shared.stop()
        if let playerVC = playerVC {
            playerVC.willMove(toParent: nil)
            playerVC.view.removeFromSuperview()
            playerVC.removeFromParent()
            self.playerVC = nil
        }
        parentCoordinator?.playVCIsShowing = false
        parentCoordinator?.reloadConstraints()
    }
}
