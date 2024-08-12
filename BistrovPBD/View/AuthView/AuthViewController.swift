//
//  AuthViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {

    weak var coordinator: AuthCoordinator!
//        weak var delegate: LogInViewControllerDelegate?
    //
    public let authView = AuthView()
    public let viewModel = AuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupView()
        setupButtons()
    }
    
    private func setupView() {
        view.addSubview(authView)
        authView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButtons() {
        authView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
    }
    
}

    //Action
extension AuthViewController {
    @objc func logInPressed() {
        setupViewModel()
        authorization()
    }
    
    public func setupViewModel() {
        let password = authView.passwordTF.text
        let username = authView.loginTF.text
        
        viewModel.initiateUserData(name: password, password: username)
        viewModel.logInUser()
        
    }
    
}

extension AuthViewController {
    public func authorization() {
        let status = viewModel.getVerificationStatus()
        if status == "failed" {
            authView.verificationFailedLabel.isHidden = false
        } else {
            print("ok")
            authView.verificationFailedLabel.isHidden = true
            viewModel.verifyUser()
            showMainVC(status: status)
        }
    }
    
    public func showMainVC(status: String) {
        coordinator.showDetail()
        
    }
}

