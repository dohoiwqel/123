//
//  PlayerVC + Action.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit

//MARK: - Action
extension PlayerViewController {
    
    public func setupButtons() {
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        fullScreenButton.addTarget(self, action: #selector(fullScreenTapped), for: .touchUpInside)
    }
    
    @objc
    public func didTapPlayPause() {
        if viewModel.isTrackPlaying() {
            viewModel.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            guard let track = track else { return }
            viewModel.play(track: track)
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        if currentCountFavourites != viewModel.getFavouriteTracksCount() {
            coodinator?.reloadData()
            coodinator?.reloadConstraints()
        }
    }
    
    @objc func fullScreenTapped() {
        guard let track = track else { return }
        let fullScreenVC = FullScreenPlayerViewController()
        fullScreenVC.fullScreendelegate = self
        fullScreenVC.configure(with: track)
        present(fullScreenVC, animated: true, completion: nil)
    }
    
    
    //MARK: - UISwipeGestureRecognizer
    public func setupSwipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }

    @objc private func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        coodinator?.removePlayerViewController()
    }
}
