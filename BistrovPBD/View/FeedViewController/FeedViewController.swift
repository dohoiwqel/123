//
//  FeedViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedView = FeedView()
    public var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        self.tableView = feedView.tracksTableView
        view.addSubview(feedView)
        feedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
