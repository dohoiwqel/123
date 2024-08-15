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
    
    public weak var maincoodinator: MainTabBarCoordinator?
    // MARK: - UI Elements
    private var authorNameTextField: UITextField!
    private var trackNameTextField: UITextField!
    private var avatarImageView: UIImageView!
    private var selectImageButton: UIButton!
    private var selectTrackButton: UIButton!
    private var saveButton: UIButton!
    private var dismissButton: UIButton!
    
    // MARK: - Properties
    private var selectedImage: UIImage?
    private var trackData: Data?
    private var trackDuration: String = ""
    
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
        self.dismissButton = addTrackView.dismissButton
    }
    
    private func setupButtons() {
        selectImageButton.addTarget(self, action: #selector(imagePressed), for: .touchUpInside)
        selectTrackButton.addTarget(self, action: #selector(trackPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTrack), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
    }
    
    @objc private func dismissPressed() {
        maincoodinator?.dismissAddTrackViewController()
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
            showAlert(title: "Ошибка", message: "Пожалуйста, убедитесь, что все поля заполнены и загружены все данные.")
            return
        }
        // Здесь вы можете сохранить трек через TrackManager (например)
        // TrackManager.shared.addTrack(...)
        TrackManager.shared.addTrack(authorName: authorName, trackName: trackName, trackData: trackData, duration: trackDuration, avatar: selectedImage)
        showAlert(title: "Успешно", message: "Трек сохранён успешно")
        // Опционально, показать сообщение о сохранении или вернуться на предыдущий экран
        maincoodinator?.dismissAddTrackViewController()
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
