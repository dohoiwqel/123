//
//  ProfileVC + Action.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit
//MARK: - Action
extension ProfileViewController: UIImagePickerControllerDelegate {
    
    public func setupButtons() {
        profileView.logOutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
    }
    
    @objc func logoutPressed() {
        print("logout pressed")
        coordinator?.didFinish()
    }
    
    
        
}
