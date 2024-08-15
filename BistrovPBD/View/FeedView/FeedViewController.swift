//
//  FeedViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit

class FeedViewController: UIViewController {
    
    public let feedView = FeedView()
    public let viewModel = TracksViewModel()
    public var tableView: UITableView!
    public var playerViewController: PlayerViewController?
    public var coordinator: MainTabBarCoordinator?  // Ссылка на координатор

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        setupUI()
        setupTableView()
        setupButtons()
    }
    
    private func setupUI() {
        self.tableView = feedView.tracksTableView
        view.addSubview(feedView)
        feedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButtons() {
        feedView.addTrackButton.addTarget(self, action: #selector(addTrackPressed), for: .touchUpInside)
    }
    
    @objc
    func addTrackPressed() {
        coordinator?.showAddTrackViewController()
    }
    
    public func showPlayerViewController(with track: TrackEntities) {
        AudioPlayerManager.shared.play(track: track)
        AudioPlayerManager.shared.pause()
        reloadTableViewConstraints()
        coordinator?.showPlayerViewController(with: track)
    }
    
}
