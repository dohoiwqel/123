//
//  PlayerViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit
import AVFoundation

class PlayerViewController: UIViewController, FullScreenPlayerDelegate {
    
    //MARK: Properties
    public var track: TrackEntities?
    public var player: AVAudioPlayer?
    public weak var coodinator: PlayerCoordinator?
    public var currentCountFavourites = FavoritesManager.shared.getAllFavoriteTrackIDs().count
    public let playerV = PlayerView()
    public let viewModel = PlayerViewModel()
    
    public var trackNameLabel: UILabel!
    public var authorNameLabel: UILabel!
    public var avatarImageView: UIImageView!
    public var playPauseButton: UIButton!
    public var playerView: UIView!
    public var fullScreenButton: UIButton!
    
    //MARK: - Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methods
    private func configure() {
        setupUI()
        setupProperties()
        setupButtons()
        setupSwipeGesture()
    }
    
    private func setupProperties() {
        trackNameLabel = playerV.trackNameLabel
        authorNameLabel = playerV.authorNameLabel
        avatarImageView = playerV.avatarImageView
        playPauseButton = playerV.playPauseButton
        playerView = playerV.playerView
        fullScreenButton = playerV.fullScreenButton
    }
    
    private func setupUI() {
        view.addSubview(playerV)
        playerV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Configure
    public func configure(with track: TrackEntities) {
        setupProperties()
        self.track = track
        self.trackNameLabel.text = track.trackName
        self.authorNameLabel.text = track.authorName
        if let avatarData = track.avatar {
            self.avatarImageView.image = UIImage(data: avatarData)
        }
        setupPlayer(with: track.trackData)
    }
    
    //MARK: - Setup player
    private func setupPlayer(with trackData: Data?) {
        guard let trackData = trackData else { return }
        
        do {
            player = try AVAudioPlayer(data: trackData)
            player?.prepareToPlay()
        } catch {
            print("Error initializing player: \(error)")
        }
    }
    
    //from coordinator
    public func didDismissFullScreenPlayer() {
        if viewModel.isTrackPlaying() {
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        coodinator?.reloadData()
        coodinator?.reloadConstraints()
    }
    
}

