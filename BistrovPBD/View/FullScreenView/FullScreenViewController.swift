//
//  FullScreenViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import UIKit
import SnapKit
protocol FullScreenPlayerDelegate: AnyObject {
    func didDismissFullScreenPlayer()
}

class FullScreenPlayerViewController: UIViewController {
    
    private var track: TrackEntities?
    weak var fullScreendelegate: FullScreenPlayerDelegate?
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down")!.withTintColor(Resources.Colors.basicColorAlpha70), for: .normal)
        button.tintColor = Resources.Colors.basicColorAlpha70
        return button
    }()
    
    private let trackArtistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
    
    private let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previousButton"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nextButton"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let trackSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.tintColor = Resources.Colors.basicColorAlpha70
        slider.thumbTintColor = Resources.Colors.basicColorAlpha70
        return slider
    }()
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
//        label.text = "00:00"
        return label
    }()
    
    public let addToFavoritesButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        updateUI()
        setupButtons()
        setupSliderUpdate()
        updateFavoriteButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fullScreendelegate?.didDismissFullScreenPlayer()
    }
    
    func configure(with track: TrackEntities) {
        let duration = AudioPlayerManager.shared.getDuration()!
        self.track = track
        self.totalTimeLabel.text = formatTime(duration)
        trackNameLabel.text = track.trackName
        trackArtistLabel.text = track.authorName
        if AudioPlayerManager.shared.isPlayingTrack() {
            let currentTime = AudioPlayerManager.shared.getCurrentTime()!
            trackSlider.value = Float(currentTime / duration)
            currentTimeLabel.text = String(format: "%02d:%02d", Int(currentTime) / 60 , Int(currentTime) % 60)
            playPauseButton.setImage(UIImage(named: "playButton"), for: .normal)
        } else {
            currentTimeLabel.text = "00:00"
        }
    }
    
    private func setupUI() {
        view.addSubview(trackImageView)
        view.addSubview(trackNameLabel)
        view.addSubview(trackArtistLabel)
        view.addSubview(playPauseButton)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(trackSlider)
        view.addSubview(currentTimeLabel)
        view.addSubview(totalTimeLabel)
        view.addSubview(dismissButton)
        view.addSubview(addToFavoritesButton)
        
        trackImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.height.equalTo(300)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        trackArtistLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        trackSlider.snp.makeConstraints { make in
            make.top.equalTo(trackArtistLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        currentTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(trackSlider.snp.leading)
            make.top.equalTo(trackSlider.snp.bottom).offset(5)
        }
        
        totalTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(trackSlider.snp.trailing)
            make.top.equalTo(trackSlider.snp.bottom).offset(5)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTimeLabel.snp.bottom).offset(20)
            make.size.equalTo(80)
        }
        
        previousButton.snp.makeConstraints { make in
            make.centerY.equalTo(playPauseButton.snp.centerY)
            make.leading.equalToSuperview().offset(30)
            make.size.equalTo(60)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(playPauseButton.snp.centerY)
            make.size.equalTo(60)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(24)
        }
        
        addToFavoritesButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(playPauseButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updateUI() {
        guard let track = track else { return }
        trackNameLabel.text = track.trackName
        trackArtistLabel.text = track.authorName
        trackImageView.image = UIImage(data: track.avatar!)
        
        if let duration = AudioPlayerManager.shared.getDuration() {
            totalTimeLabel.text = formatTime(duration)
            totalTimeLabel.text = track.duration
        }
        
        if AudioPlayerManager.shared.isPlayingTrack() {
            playPauseButton.setImage(UIImage(named: "playButton"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
        }
    }
    
    private func setupButtons() {
        trackSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(previousTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        addToFavoritesButton.addTarget(self, action: #selector(addToFavouritesPressed), for: .touchUpInside)
    }
    
    private func setupSliderUpdate() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateSlider()
        }
    }
    
    private func updateSlider() {
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
                print(currentTrack)
                configure(with: currentTrack)
            }
        }
    
    @objc private func sliderValueChanged() {
        guard let duration = AudioPlayerManager.shared.getDuration() else { return }
        let newTime = TimeInterval(trackSlider.value) * duration
        AudioPlayerManager.shared.seek(to: newTime)
        currentTimeLabel.text = formatTime(newTime)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
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
    
    private func updateFavoriteButton() {
        guard let track = track, let id = track.id else { return }
        
        let isFavorite = FavoritesManager.shared.isFavoriteTrack(id: id)
        print(isFavorite)
        let imageName = isFavorite ? "starSelected" : "starUnselected"
        addToFavoritesButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
