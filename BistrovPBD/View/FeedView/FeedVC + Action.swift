//
//  FeedVC + Action.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation

//MARK: - Action
extension FeedViewController {
    public func setupButtons() {
        feedView.addTrackButton.addTarget(self, action: #selector(addTrackPressed), for: .touchUpInside)
    }
    
    @objc
    func addTrackPressed() {
        coordinator?.showAddTrackViewController()
    }
    
    public func showPlayerViewController(with track: TrackEntities) {
        viewModel.playPause(track: track)
        reloadTableViewConstraints()
        coordinator?.showPlayerViewController(with: track)
    }
}
