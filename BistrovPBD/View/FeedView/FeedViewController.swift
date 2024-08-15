//
//  FeedViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: Properties
    public let feedView = FeedView()
    public let viewModel = TracksViewModel()
    public var tableView: UITableView!
    public var playerViewController: PlayerViewController?
    public var coordinator: FeedCoordinator?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methods
    private func configure() {
        setupViewModel()
        setupUI()
        setupTableView()
        setupButtons()
    }
    
    private func setupViewModel() {
        if viewModel.getUsername() != "admin" {
            feedView.addTrackButton.isHidden = true
        }
        
    }
    
    private func setupUI() {
        self.tableView = feedView.tracksTableView
        view.addSubview(feedView)
        feedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
