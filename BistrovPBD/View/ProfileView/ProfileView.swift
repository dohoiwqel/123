//
//  ProfileView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    
    
    public let profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.text = AuthManager.shared.getCurrentUserName()!
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.makeBorders(width: 2)
        button.makeBordersColor(color: UIColor.red.cgColor)
        button.makeRadius(radius: 15)
        button.setTitle("Выйти из аккаунта", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    public let aboutMe: UILabel = {
        let label = UILabel()
        label.text = "Возможности аккаунта:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = Resources.Colors.basicColorAlpha70
        return label
    }()
    
    public let backTextView: UIView = {
        let view = UIView()
        view.makeBorders(width: 2)
        view.makeBordersColor(color: Resources.Colors.basicCGColor)
        view.backgroundColor = .black
        view.makeRadius(radius: 15)
        return view
    }()
    
    public let textTextView: UITextView = {
        let tf = UITextView()
        tf.textColor = Resources.Colors.basicColorAlpha70
        if AuthManager.shared.getCurrentUserName() != "admin" {
            tf.text = " 1. Возможность просмотра ленты с треками. \n 2.Возможность добавлять треки в избранное.\n 3. Возможность удалять треки из избранного"
        }
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.isScrollEnabled = true
        tf.backgroundColor = .black
        return tf
    }()
    
    
    public let avatarButton: UIButton = {
        let im = UIButton()
        
        if AuthManager.shared.getCurrentUserName() == "admin" {
            im.setImage(UIImage(named: "adminAvatar"), for: .normal)
        } else {
            im.setImage(UIImage(named: "userAvatar"), for: .normal)
        }
        im.tintColor = Resources.Colors.basicColorAlpha70
        im.imageView?.contentMode = .scaleAspectFit
        
        im.makeBorders(width: 2)
        im.makeRadius(radius: 15)
        im.clipsToBounds = true
//        im.backgroundColor = .blue
        im.makeBordersColor(color: Resources.Colors.basicCGColor)
        return im
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
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(profileLabel)
        addSubview(logOutButton)
        addSubview(avatarButton)
        addSubview(aboutMe)
        addSubview(backTextView)
        addSubview(textTextView)
        addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        avatarButton.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.top.equalTo(profileLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        aboutMe.snp.makeConstraints { make in
            make.top.equalTo(avatarButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
        }
        
        backTextView.snp.makeConstraints { make in
            make.top.equalTo(aboutMe.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(29)
            make.trailing.equalToSuperview().inset(29)
            make.height.equalTo(250)
        }
        
        textTextView.snp.makeConstraints { make in
            make.leading.equalTo(aboutMe.snp.leading)
            make.top.equalTo(backTextView.snp.top).offset(5)
            make.height.equalTo(240)
            make.trailing.equalToSuperview().inset(40)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(textTextView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(29)
            make.trailing.equalToSuperview().inset(29)
            make.height.equalTo(70)
        }
    }

}
