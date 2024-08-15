//
//  FeedVC + Table.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
import SnapKit

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountItems()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseId, for: indexPath) as? TrackTableViewCell else {
            print("Failure")
            return UITableViewCell()
        }
        let track = viewModel.getTrack(by: indexPath.row)
        cell.setupCell(trackName: track.trackName ?? "nil", authorName: track.trackName ?? "nil", timeLimit: String(track.duration!), image: UIImage(data: track.avatar! )!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedTrack = viewModel.getTrack(by: indexPath.row)
            
            // Убираем предыдущий плеер, если он уже есть
            playerViewController?.view.removeFromSuperview()
            playerViewController?.removeFromParent()

            // Отображаем новый плеер
            showPlayerViewController(with: selectedTrack)
        }
}