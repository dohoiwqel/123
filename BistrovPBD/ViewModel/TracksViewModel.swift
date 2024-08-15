//
//  TracksViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation

class TracksViewModel {
    let trackManager = TrackManager.shared
    
    public func getCountItems() -> Int {
        return trackManager.fetchTracks().count
    }
    
    public func getTrack(by id: Int) -> TrackEntities {
        return trackManager.fetchTracks()[id]
    }
    
    public func removeTrack(by id: Int) {
        let track = getTrack(by: id)
        trackManager.deleteTrack(track: track)
    }
}
