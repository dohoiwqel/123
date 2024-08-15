//
//  AddTrackVC + UIImagePickerDelegate.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit

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
