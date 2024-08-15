//
//  AudioPlayer.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import AVFoundation

class AudioPlayerManager {
    
    //MARK: Properties
    static let shared = AudioPlayerManager()

    private var player: AVAudioPlayer?
    private var currentTrack: TrackEntities?
    private var isPlaying: Bool = false
    private var tracks: [TrackEntities] = []
    
    private init() {}
    
    func setTracks(_ tracks: [TrackEntities]) {
        self.tracks = tracks
    }
    
    func play(track: TrackEntities) {
        guard track != currentTrack else {
            player?.play()
            isPlaying = true
            return
        }

        currentTrack = track
        setupPlayer(with: track.trackData)
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func stop() {
        player?.stop()
        isPlaying = false
        player = nil
        currentTrack = nil
    }
    
    func seek(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    func getCurrentTime() -> TimeInterval? {
        return player?.currentTime
    }
    
    func getDuration() -> TimeInterval? {
        return player?.duration
    }
    
    func isPlayingTrack() -> Bool {
        return isPlaying
    }
    
    func getCurrentTrack() -> TrackEntities? {
        return currentTrack
    }
    
    func playNextTrack() {
        let tracks = TrackManager.shared.fetchTracks()
        guard let currentTrack = currentTrack else { return }
        guard let currentIndex = tracks.firstIndex(where: { $0.trackName == currentTrack.trackName }) else { return }
        pause()
        let nextIndex = (currentIndex + 1) % tracks.count
        let nextTrack = tracks[nextIndex]
        play(track: nextTrack)
    }
    
    func playPreviousTrack() {
        let tracks = TrackManager.shared.fetchTracks()
        guard let currentTrack = currentTrack else { return }
        guard let currentIndex = tracks.firstIndex(where: { $0.id == currentTrack.id }) else { return }
        
        let previousIndex = (currentIndex - 1 + tracks.count) % tracks.count
        let previousTrack = tracks[previousIndex]
        play(track: previousTrack)
    }
    
    private func setupPlayer(with trackData: Data?) {
        guard let trackData = trackData else { return }
        
        do {
            player = try AVAudioPlayer(data: trackData)
            player?.prepareToPlay()
        } catch {
            print("Error initializing player: \(error)")
        }
    }
}
