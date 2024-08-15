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
        guard let duration = AudioPlayerManager.shared.getDuration(),
              let currentTime = AudioPlayerManager.shared.getCurrentTime() else {
            return
        }
        trackSlider.value = Float(currentTime / duration)
        currentTimeLabel.text = formatTime(currentTime)
    }
    
    @objc private func playPauseTapped() {
        if AudioPlayerManager.shared.isPlayingTrack() {
            AudioPlayerManager.shared.pause()
            playPauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
        } else {
            guard let track = track else { return }
            AudioPlayerManager.shared.play(track: track)
            playPauseButton.setImage(UIImage(named: "playButton"), for: .normal)
        }
    }
    
    @objc private func previousTapped() {
            AudioPlayerManager.shared.playPreviousTrack()
            if let currentTrack = AudioPlayerManager.shared.getCurrentTrack() {
                configure(with: currentTrack)
            }
        }
        
    @objc private func nextTapped() {
        
        AudioPlayerManager.shared.playNextTrack()
        if let currentTrack = AudioPlayerManager.shared.getCurrentTrack() {
            configure(with: currentTrack)
        }
    }
    
    @objc private func sliderValueChanged() {
        guard let duration = AudioPlayerManager.shared.getDuration() else { return }
        let newTime = TimeInterval(trackSlider.value) * duration
        AudioPlayerManager.shared.seek(to: newTime)
        currentTimeLabel.text = formatTime(newTime)
    }
    
    //MARK: - Format time
    public func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func dismissPressed() {
        self.dismiss(animated: true) {
            print("ok")
        }
    }
    
    @objc func addToFavouritesPressed() {
        guard let track = track, let id = track.id else { return }
                
        if FavoritesManager.shared.isFavoriteTrack(id: id) {
            FavoritesManager.shared.removeFavoriteTrack(id: id)
        } else {
            FavoritesManager.shared.saveFavoriteTrack(id: id)
        }
        updateFavoriteButton()
    }
    
    //MARK: - favourite button
    public func updateFavoriteButton() {
        guard let track = track, let id = track.id else { return }
        
        let isFavorite = FavoritesManager.shared.isFavoriteTrack(id: id)
        let imageName = isFavorite ? "starSelected" : "starUnselected"
        addToFavoritesButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
