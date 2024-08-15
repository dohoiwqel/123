//
//  ProfileViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//


import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: ProfileCoordinator?
    public let profileView = ProfileView()
    public let viewModel = ProfileViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: Methods
    private func configure() {
        setupViewModel()
        setupView()
        setupButtons()
    }
    
    private func setupView() {
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupViewModel() {
        profileView.textLabel.text = viewModel.getText()
        profileView.avatarButton.setImage(UIImage(named: viewModel.getAvatarName()), for: .normal)
        profileView.profileLabel.text = viewModel.getUsername()
    }
}


        
        


