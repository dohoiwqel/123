//
//  ProfileView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    //MARK: Properties
    public let profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let logOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Images.Buttons.exitButton), for: .normal)
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
    
    public let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Resources.Colors.basicColorAlpha70
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor = .black
        return label
    }()
    
    
    public let avatarButton: UIButton = {
        let im = UIButton()
        im.tintColor = Resources.Colors.basicColorAlpha70
        im.imageView?.contentMode = .scaleAspectFit
        im.makeBorders(width: 2)
        im.makeRadius(radius: 15)
        im.clipsToBounds = true
        im.makeBordersColor(color: Resources.Colors.basicCGColor)
        return im
    }()
    
    //MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
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
        addSubview(textLabel)
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
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(aboutMe.snp.leading)
            make.top.equalTo(backTextView.snp.top).offset(5)
            make.height.equalTo(240)
            make.trailing.equalToSuperview().inset(40)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(29)
            make.size.equalTo(40)
        }
    }

}
