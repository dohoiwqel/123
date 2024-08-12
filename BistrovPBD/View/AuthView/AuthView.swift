//
//  AuthView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
import SnapKit

class AuthView: UIView, UITextFieldDelegate {
    
    private let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let loginTF: UITextField = {
        let tf = UITextField()
        tf.createBasicTextField(text: "Введите логин")
        tf.autocapitalizationType = .none
        tf.textContentType = .username
        return tf
    }()
    
    public let passwordTF: UITextField = {
        let tf = UITextField()
        tf.createBasicTextField(text: "Введите пароль")
        tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        return tf
    }()
    
    public let logInButton: UIButton = {
        let button = UIButton()
        button.createBasicButton(text: "Войти")
        button.makeBorders(width: 5)
        button.makeRadius(radius: 16)
        button.makeBordersColor(color: Resources.Colors.basicCGColor)
        return button
    }()
    
    public let verificationFailedLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация не пройдена"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        settingForView()
        setupSubviews()
        setupConstraints()
    }
    
    private func settingForView() {
        backgroundColor = .white
    }

    private func setupSubviews() {
        addSubview(logInLabel)
        addSubview(loginTF)
        addSubview(passwordTF)
        addSubview(logInButton)
        addSubview(verificationFailedLabel)
    }
    
    private func setupConstraints() {
        
        logInLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(81)
            make.centerX.equalToSuperview()
        }
        loginTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(270)
            make.centerX.equalToSuperview()
            make.width.equalTo(357)
            make.height.equalTo(47)
        }
        passwordTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(loginTF.snp.size)
            make.top.equalTo(loginTF.snp.bottom).offset(24)
        }
        logInButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(700)
            make.centerX.equalToSuperview()
            make.width.equalTo(141)
            make.height.equalTo(46)
        }
        verificationFailedLabel.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
}

