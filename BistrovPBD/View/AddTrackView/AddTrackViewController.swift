//
//  AddTrackViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
import MobileCoreServices // Для типов документов
import AVFoundation // Для работы с аудио и видео

class AddTrackViewController: UIViewController {
    
    // MARK: - UI Elements
    private var authorNameTextField: UITextField!
    private var trackNameTextField: UITextField!
    private var avatarImageView: UIImageView!
    private var selectImageButton: UIButton!
    private var selectTrackButton: UIButton!
    private var saveButton: UIButton!
    
    // MARK: - Properties
    private var selectedImage: UIImage?
    private var trackData: Data?
    private var trackDuration: Double = 0.0
    
    private let addTrackView = AddTrackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configure()
    }
    
    private func configure() {
        setupViews()
        setupUI()
        setupButtons()
    }
    
    private func setupUI() {
        view.addSubview(addTrackView)
        
        addTrackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupViews() {
        self.authorNameTextField = addTrackView.authorNameTextField
        self.trackNameTextField = addTrackView.trackNameTextField
        self.avatarImageView = addTrackView.avatarImageView
        self.selectImageButton = addTrackView.selectImageButton
        self.selectTrackButton = addTrackView.selectTrackButton
        self.saveButton = addTrackView.loadButton
    }
    
    private func setupButtons() {
        selectImageButton.addTarget(self, action: #selector(imagePressed), for: .touchUpInside)
        selectTrackButton.addTarget(self, action: #selector(trackPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTrack), for: .touchUpInside)
    }
    
    @objc private func imagePressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @objc private func trackPressed() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAudio)], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }

    @objc private func saveTrack() {
        guard let authorName = authorNameTextField.text, !authorName.isEmpty,
              let trackName = trackNameTextField.text, !trackName.isEmpty,
              let trackData = trackData else {
            // Обработка некорректного ввода
            showAlert(title: "Error", message: "Please make sure all fields are filled and a track is selected.")
            return
        }
        
        // Здесь вы можете сохранить трек через TrackManager (например)
        // TrackManager.shared.addTrack(...)
        TrackManager.shared.addTrack(authorName: authorName, trackName: trackName, trackData: trackData, duration: String(trackDuration), avatar: selectedImage)
        showAlert(title: "Success", message: "Track successfully saved.")
        // Опционально, показать сообщение о сохранении или вернуться на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension AddTrackViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            avatarImageView.image = image
            addTrackView.isImageLoaded.image = UIImage(systemName: "checkmark.square")
            addTrackView.isImageLoaded.tintColor = Resources.Colors.basicColor
        } else {
            addTrackView.isImageLoaded.image = UIImage(systemName: "xmark.square")
            addTrackView.isImageLoaded.tintColor = Resources.Colors.redColor
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIDocumentPickerDelegate

extension AddTrackViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileURL = urls.first else { return }
        do {
            trackData = try Data(contentsOf: fileURL)
            calculateTrackDuration(url: fileURL)
            addTrackView.isTrackLoaded.image = UIImage(systemName: "checkmark.square")
            addTrackView.isTrackLoaded.tintColor = Resources.Colors.basicColor
        } catch {
            print("Ошибка при загрузке данных трека: \(error)")
            addTrackView.isTrackLoaded.image = UIImage(systemName: "xmark.square")
            addTrackView.isTrackLoaded.tintColor = Resources.Colors.redColor
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Обработка отмены
    }
    
    private func calculateTrackDuration(url: URL) {
        let asset = AVURLAsset(url: url)
        let duration = asset.duration
        trackDuration = CMTimeGetSeconds(duration)
        print("Длительность трека: \(trackDuration) секунд")
    }
}
