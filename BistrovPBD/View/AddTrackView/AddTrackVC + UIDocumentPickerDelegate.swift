//
//  AddTrackVC + UIDocumentPickerDelegate.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit
import AVFoundation // Для работы с аудио и видео

// MARK: - UIDocumentPickerDelegate
extension AddTrackViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileURL = urls.first else { return }
        do {
            trackData = try Data(contentsOf: fileURL)
            trackDuration = calculateTrackDuration(url: fileURL)
            addTrackView.isTrackLoaded.image = UIImage(systemName: "checkmark.square")
            addTrackView.isTrackLoaded.tintColor = Resources.Colors.basicColor
        } catch {
            print("Ошибка при загрузке данных трека: \(error)")
            addTrackView.isTrackLoaded.image = UIImage(systemName: "xmark.square")
            addTrackView.isTrackLoaded.tintColor = Resources.Colors.redColor
        }
    }
    
    private func calculateTrackDuration(url: URL) -> String {
        let asset = AVURLAsset(url: url)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)
        let minutes = Int(durationInSeconds) / 60
        let seconds = Int(durationInSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
