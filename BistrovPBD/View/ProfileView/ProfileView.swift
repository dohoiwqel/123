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
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let logOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logout.png"), for: .normal)
        button.backgroundColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    public let aboutMe: UILabel = {
        let label = UILabel()
        label.text = "О себе:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = Resources.Colors.basicColorAlpha70
        return label
    }()
    
    public let backTextView: UIView = {
        let view = UIView()
        view.makeBorders(width: 5)
        view.makeBordersColor(color: Resources.Colors.basicCGColor)
        view.makeRadius(radius: 15)
        return view
    }()
    
    public let textTextView: UITextView = {
        let tf = UITextView()
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.backgroundColor = .white
        tf.isScrollEnabled = true
        return tf
    }()
    
    
    public let avatarButton: UIButton = {
        let im = UIButton()
        
//        if AuthManager.shared.getCurrentUserName() == "user" {
//            im.image = UIImage(named: "userAvatar")
//        } else {
//            im.image = UIImage(named: "adminAvatar")
//        }
        im.setTitle("Аватар", for: .normal)
        im.setTitleColor(Resources.Colors.basicColorAlpha70, for: .normal)
        im.imageView?.contentMode = .scaleAspectFit
        
        im.makeBorders(width: 5)
        im.makeRadius(radius: 15)
        im.clipsToBounds = true
//        im.backgroundColor = .blue
        im.makeBordersColor(color: Resources.Colors.basicCGColor)
        return im
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
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
    }
    
    private func setupConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(82)
            make.centerX.equalToSuperview()
        }
        logOutButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(profileLabel.snp.top)
            make.trailing.equalToSuperview().inset(29)
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
    }

}
