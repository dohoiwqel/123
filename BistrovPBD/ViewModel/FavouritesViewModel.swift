//
//  FavouritesViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation

class FavouritesViewModel {
    let favouritesManager = FavoritesManager.shared
    let trackManager = TrackManager.shared
    var favouritesTracks: [TrackEntities] = []
    
    public func getCountItems() -> Int {
        let favouritesIds = favouritesManager.getAllFavoriteTrackIDs()
        let allTracks = trackManager.fetchTracks()
        self.favouritesTracks = allTracks.filter{ favouritesIds.contains($0.id!) }
        return favouritesTracks.count
    }
    
    public func getTrack(by id: Int) -> TrackEntities {
        return favouritesTracks[id]
    }
    
    public func removeTrack(by id: Int) {
        guard let trackId = getTrack(by: id).id else { return }
        favouritesManager.removeFavoriteTrack(id: trackId)
    }
}
