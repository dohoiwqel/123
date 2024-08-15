//
//  PlayerViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
class PlayerViewModel {
    
    public func isTrackPlaying() -> Bool {
        return AudioPlayerManager.shared.isPlayingTrack()
    }
    
    public func play(track: TrackEntities) {
        AudioPlayerManager.shared.play(track: track)
    }
    
    public func pause() {
        AudioPlayerManager.shared.pause()
    }
    
    public func getFavouriteTracksCount() -> Int {
        return FavoritesManager.shared.getAllFavoriteTrackIDs().count
    }
}
