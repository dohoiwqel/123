//
//  FullScreenView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation
import UIKit

class FullScreenView: UIView {
    
    public let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    public let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down")!.withTintColor(Resources.Colors.basicColorAlpha70), for: .normal)
        button.tintColor = Resources.Colors.basicColorAlpha70
        return button
    }()
    
    public let trackArtistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
    
    public let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let playPauseButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    public let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previousButton"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    public let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nextButton"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    public let trackSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.tintColor = Resources.Colors.basicColorAlpha70
        slider.thumbTintColor = Resources.Colors.basicColorAlpha70
        return slider
    }()
    
    public let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    public let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
//        label.text = "00:00"
        return label
    }()
    
    public let addToFavoritesButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
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
        addSubview(trackImageView)
        addSubview(trackNameLabel)
        addSubview(trackArtistLabel)
        addSubview(playPauseButton)
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(trackSlider)
        addSubview(currentTimeLabel)
        addSubview(totalTimeLabel)
        addSubview(dismissButton)
        addSubview(addToFavoritesButton)
    }
    
    private func setupConstraints() {
        
        
        trackImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.width.height.equalTo(300)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        trackArtistLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        trackSlider.snp.makeConstraints { make in
            make.top.equalTo(trackArtistLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        currentTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(trackSlider.snp.leading)
            make.top.equalTo(trackSlider.snp.bottom).offset(5)
        }
        
        totalTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(trackSlider.snp.trailing)
            make.top.equalTo(trackSlider.snp.bottom).offset(5)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTimeLabel.snp.bottom).offset(20)
            make.size.equalTo(80)
        }
        
        previousButton.snp.makeConstraints { make in
            make.centerY.equalTo(playPauseButton.snp.centerY)
            make.leading.equalToSuperview().offset(30)
            make.size.equalTo(60)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(playPauseButton.snp.centerY)
            make.size.equalTo(60)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(24)
        }
        
        addToFavoritesButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(playPauseButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
