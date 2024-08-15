//
//  FeedVC + Table.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
import SnapKit

//MARK: - TableView
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseId)
    }
    
    //coordinator
    func reloadTracks() {
        guard let tableView = tableView else { return }
        tableView.reloadData()
    }
    //coordinator
    func reloadTableViewConstraints() {
        guard let coordinator = coordinator else { return }
        tableView = feedView.tracksTableView
        if coordinator.isPlayerShowing()  {
            tableView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(170)
            }
        } else {
            tableView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(100)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             viewModel.removeTrack(by: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
         }
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
        // Отображаем новый плеер
        showPlayerViewController(with: selectedTrack)
    }
}
