//
//  PlayerView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit

class PlayerView: UIView {
    
    public let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    public let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    public let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    public let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let playImage = UIImage(systemName: "play.fill")
        button.setImage(playImage, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    public let playerView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.basicColorAlpha70
        view.layer.cornerRadius = 10
        return view
    }()
    
    public let fullScreenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
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
        addSubview(playerView)
        playerView.addSubview(trackNameLabel)
        playerView.addSubview(authorNameLabel)
        playerView.addSubview(avatarImageView)
        playerView.addSubview(fullScreenButton)
        playerView.addSubview(playPauseButton)
    }
    
    private func setupConstraints() {
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(10)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(5)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(41.5)
            make.centerY.equalToSuperview()
        }
        
        fullScreenButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
