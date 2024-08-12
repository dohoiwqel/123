//
//  ProfileViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//


import UIKit

class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?
    weak var coordinator: MainTabBarCoordinator?
    public let profileView = ProfileView()
    
//    public let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        viewModel.updateText(newText: profileView.textTextView.text)
    }
    
    private func configure() {
        updateProfileView()
        setupView()
        setupButtons()
        
//        print(UserManager.shared.getUser(forUsername: "admin"))


    }
    
    private func updateProfileView() {
//        profileView.profileLabel.text = viewModel.getUsername().uppercased()
//        profileView.avatarButton.setImage(viewModel.getImage(), for: .normal)
//        profileView.textTextView.text = viewModel.getText()
    }
    
    private func setupView() {
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//Action
extension ProfileViewController {
    
    private func setupButtons() {
        profileView.logOutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        
        profileView.avatarButton.addTarget(self, action: #selector(setAvatar), for: .touchUpInside)
    }
    
    @objc func setAvatar() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
//        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func logoutPressed() {
        //выход их аккаунта
        print("logout pressed")
        
        coordinator?.didFinish()
    }
    
    
        
}
        
        


