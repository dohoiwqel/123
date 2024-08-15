//
//  FullScreenViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation

class FullScreenViewModel {
    
    //MARK: AudioPlayerManager
    public func isTrackPlaying() -> Bool {
        return AudioPlayerManager.shared.isPlayingTrack()
    }
    
    //play
    public func play(track: TrackEntities) {
        return AudioPlayerManager.shared.play(track: track)
    }
    
    //pause
    public func pause() {
        return AudioPlayerManager.shared.pause()
    }
    
    //previous
    public func playPreviousTrack() {
        AudioPlayerManager.shared.playPreviousTrack()
    }
    
    //next
    public func playNextTrack() {
        AudioPlayerManager.shared.playNextTrack()
    }
    
    public func seek(to time: TimeInterval) {
        AudioPlayerManager.shared.seek(to: time)
    }
    
    public func getCurrentTrack() -> TrackEntities? {
        return AudioPlayerManager.shared.getCurrentTrack()
    }
    
    public func getDuration() -> TimeInterval? {
        return AudioPlayerManager.shared.getDuration()
    }
    
    public func getCurrentTime() -> TimeInterval {
        return AudioPlayerManager.shared.getCurrentTime()!
    }

    //MARK: - FavouritesManager
    
    public func isFavoriteTrack(id: UUID) -> Bool {
        return FavoritesManager.shared.isFavoriteTrack(id: id)
    }
    
    public func removeFavoriteTrack(id: UUID) {
        FavoritesManager.shared.removeFavoriteTrack(id: id)
    }
    
    public func saveFavoriteTrack(id: UUID) {
        FavoritesManager.shared.saveFavoriteTrack(id: id)
    }
    
    //MARK: - Format time
    public func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
