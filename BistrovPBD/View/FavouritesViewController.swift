//
//  FavouritesViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit

class FavouritesViewController: UIViewController {
    
    //MARK: Properties
    public var coordinator: FavouritesCoordinator?
    public let favouritesView = FavouritesView()
    public var tableView: UITableView!
    public var viewModel = FavouritesViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: Methods
    private func configure() {
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.addSubview(favouritesView)
        tableView = favouritesView.favouritesTableView
        favouritesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func showPlayerViewController(with track: TrackEntities) {
        AudioPlayerManager.shared.play(track: track)
        AudioPlayerManager.shared.pause()
        reloadTableViewConstraints()
        coordinator?.showPlayerViewController(with: track)
    }
}
