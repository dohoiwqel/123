//
//  FullScreenVC.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit

//MARK: - Action
extension FullScreenPlayerViewController {
    public func setupButtons() {
        trackSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(previousTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        addToFavoritesButton.addTarget(self, action: #selector(addToFavouritesPressed), for: .touchUpInside)
    }
    
    //MARK: - slider update
    public func setupSliderUpdate() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateSlider()
        }
    }
    
    public func updateSlider() {
        guard let duration = viewModel.getDuration() else {
            return
        }
        let currentTime = viewModel.getCurrentTime()
        trackSlider.value = Float(currentTime / duration)
        currentTimeLabel.text = viewModel.formatTime(currentTime)
    }
    
    @objc private func playPauseTapped() {
        if viewModel.isTrackPlaying() {
            viewModel.pause()
            playPauseButton.setImage(UIImage(named: Resources.Images.Buttons.pauseButton), for: .normal)
        } else {
            guard let track = track else { return }
            viewModel.play(track: track)
            playPauseButton.setImage(UIImage(named: Resources.Images.Buttons.playButton), for: .normal)
        }
    }
    
    @objc private func previousTapped() {
        viewModel.playPreviousTrack()
        if let currentTrack = viewModel.getCurrentTrack() {
            configure(with: currentTrack)
        }
    }
        
    @objc private func nextTapped() {
        viewModel.playNextTrack()
        if let currentTrack = viewModel.getCurrentTrack() {
            configure(with: currentTrack)
        }
    }
    
    @objc private func sliderValueChanged() {
        guard let duration = viewModel.getDuration() else { return }
        let newTime = TimeInterval(trackSlider.value) * duration
        viewModel.seek(to: newTime)
        currentTimeLabel.text = viewModel.formatTime(newTime)
    }
    
    
    
    @objc func dismissPressed() {
        self.dismiss(animated: true) {
            print("ok")
        }
    }
    
    @objc func addToFavouritesPressed() {
        guard let track = track, let id = track.id else { return }
                
        if viewModel.isFavoriteTrack(id: id) {
            viewModel.removeFavoriteTrack(id: id)
        } else {
            viewModel.saveFavoriteTrack(id: id)
        }
        updateFavoriteButton()
    }
    
    //MARK: - favourite button
    public func updateFavoriteButton() {
        guard let track = track, let id = track.id else { return }
        
        let isFavorite = viewModel.isFavoriteTrack(id: id)
        let imageName = isFavorite ? Resources.Images.Buttons.starSelected
        : Resources.Images.Buttons.starUnselected
        addToFavoritesButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
