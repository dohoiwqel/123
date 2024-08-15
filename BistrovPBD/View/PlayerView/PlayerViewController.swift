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
    

    private var track: TrackEntities?
    private var player: AVAudioPlayer?
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let playImage = UIImage(systemName: "play.fill")
        button.setImage(playImage, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let playerView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.basicColorAlpha70
        view.layer.cornerRadius = 10
        return view
    }()
    
    public let fullScreenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configure()
    }
    
    private func configure() {
        setupSubviews()
        setupConstraints()
        setupButtons()
    }
    
    private func setupSubviews() {
        view.addSubview(playerView)
        playerView.addSubview(trackNameLabel)
        playerView.addSubview(authorNameLabel)
        playerView.addSubview(avatarImageView)
        playerView.addSubview(fullScreenButton)
        playerView.addSubview(playPauseButton)
    }
    
    private func setupConstraints() {
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(10)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(5)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(41.5)
            make.centerY.equalToSuperview()
        }
        
        fullScreenButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func configure(with track: TrackEntities) {
        self.track = track
        self.trackNameLabel.text = track.trackName
        self.authorNameLabel.text = track.authorName
        if let avatarData = track.avatar {
            self.avatarImageView.image = UIImage(data: avatarData)
        }
        setupPlayer(with: track.trackData)
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
    
    func didDismissFullScreenPlayer() {
        if AudioPlayerManager.shared.isPlayingTrack() {
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
}

extension PlayerViewController {
    public func setupButtons() {
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        fullScreenButton.addTarget(self, action: #selector(fullScreenTapped), for: .touchUpInside)
    }
    
    @objc 
    public func didTapPlayPause() {
        
        if AudioPlayerManager.shared.isPlayingTrack() {
            AudioPlayerManager.shared.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            guard let track = track else { return }
            AudioPlayerManager.shared.play(track: track)
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @objc func fullScreenTapped() {
        guard let track = track else { return }
        let fullScreenVC = FullScreenPlayerViewController()
        fullScreenVC.delegate = self
        fullScreenVC.configure(with: track)
        present(fullScreenVC, animated: true, completion: nil)
    }
}
