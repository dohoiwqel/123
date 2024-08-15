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
    
    //MARK: Properties
    public var track: TrackEntities?
    weak var fullScreendelegate: FullScreenPlayerDelegate?
    
    public var trackNameLabel: UILabel!
    
    public var dismissButton: UIButton!
    
    public var trackArtistLabel: UILabel!
    
    public var trackImageView: UIImageView!
    
    public var playPauseButton: UIButton!
    
    public var previousButton: UIButton!
    
    public var nextButton: UIButton!
    
    public var trackSlider: UISlider!
    
    public var currentTimeLabel: UILabel!
    
    public var totalTimeLabel: UILabel!
    
    public var addToFavoritesButton: UIButton!
    
    public var fullScreenView = FullScreenView()
    public var viewModel = FullScreenViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fullScreendelegate?.didDismissFullScreenPlayer()
    }
    
    //MARK: - Methods
    private func configure() {
        setupProperties()
        setupUI()
        updateUI()
        setupButtons()
        setupSliderUpdate()
        updateFavoriteButton()
    }
    
    private func setupProperties() {
        trackNameLabel = fullScreenView.trackNameLabel
        dismissButton = fullScreenView.dismissButton
        trackArtistLabel = fullScreenView.trackArtistLabel
        trackImageView = fullScreenView.trackImageView
        playPauseButton = fullScreenView.playPauseButton
        previousButton = fullScreenView.previousButton
        nextButton = fullScreenView.nextButton
        trackSlider = fullScreenView.trackSlider
        currentTimeLabel = fullScreenView.currentTimeLabel
        totalTimeLabel = fullScreenView.totalTimeLabel
        totalTimeLabel = fullScreenView.totalTimeLabel
        addToFavoritesButton = fullScreenView.addToFavoritesButton
    }
    
    private func setupUI() {
        view.addSubview(fullScreenView)
        
        fullScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Configure
    func configure(with track: TrackEntities) {
        setupProperties()
        viewModel.play(track: track)
        guard let duration = viewModel.getDuration() else { return }
        self.track = track
        self.totalTimeLabel.text = viewModel.formatTime(duration)
        
        trackNameLabel.text = track.trackName
        trackArtistLabel.text = track.authorName
        if viewModel.isTrackPlaying()   {
            let currentTime = viewModel.getCurrentTime()
            trackSlider.value = Float(currentTime / duration )
            currentTimeLabel.text = String(format: "%02d:%02d", Int(currentTime) / 60 , Int(currentTime) % 60)
            playPauseButton.setImage(UIImage(named: Resources.Images.Buttons.playButton), for: .normal)
        } else {
            currentTimeLabel.text = "00:00"
        }
        updateFavoriteButton()
    }
    
    
    
    private func updateUI() {
        guard let track = track else { return }
        trackNameLabel.text = track.trackName
        trackArtistLabel.text = track.authorName
        trackImageView.image = UIImage(data: track.avatar!)
        
        if let duration = viewModel.getDuration() {
            totalTimeLabel.text = viewModel.formatTime(duration)
            totalTimeLabel.text = track.duration
        }
        
        if AudioPlayerManager.shared.isPlayingTrack() {
            playPauseButton.setImage(UIImage(named: Resources.Images.Buttons.playButton), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: Resources.Images.Buttons.pauseButton), for: .normal)
        }
    }
    
    
}
