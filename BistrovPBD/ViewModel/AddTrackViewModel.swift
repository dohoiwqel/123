//
//  AddTrackViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit
class AddTrackViewModel {
    
    private let trackManager = TrackManager.shared
    
    func addTrack(authorname: String,trackName: String, trackData: Data, duration: String, avatar: UIImage?) {
        trackManager.addTrack(authorName: authorname, trackName: trackName, trackData: trackData, duration: duration, avatar: avatar)
    }
}
