//
//  AddTrackVC + Action.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit
import MobileCoreServices // Для типов документов

//MARK: - Action
extension AddTrackViewController {
    public func setupButtons() {
        selectImageButton.addTarget(self, action: #selector(imagePressed), for: .touchUpInside)
        selectTrackButton.addTarget(self, action: #selector(trackPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTrack), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
    }
    
    @objc private func dismissPressed() {
        coordinator?.dismissAddTrackViewController()
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

    //MARK: AddTrackViewModel
    @objc private func saveTrack() {
        guard let authorName = authorNameTextField.text, !authorName.isEmpty,
              let trackName = trackNameTextField.text, !trackName.isEmpty,
              let trackData = trackData else {
            showAlert(title: "Ошибка", message: "Пожалуйста, убедитесь, что все поля заполнены и загружены все данные.")
            return
        }
        viewModel.addTrack(authorname: authorName, trackName: trackName, trackData: trackData, duration: trackDuration, avatar: selectedImage)
        showAlert(title: "Успешно", message: "Трек сохранён успешно.")
        coordinator?.dismissAddTrackViewController()
    }
    
    //MARK: - UIAlertController
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
