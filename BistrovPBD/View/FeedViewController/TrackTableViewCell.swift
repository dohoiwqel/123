//
//  TrackTableViewCell.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit

class TrackTableViewCell: UITableViewCell {
    
    static let reuseId = "TrackTableViewCell"
    
    private let trackName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Resources.Colors.basicColor
        label.text = "Supersonic"
        return label
    }()
    
    private let trackAvatarImage: UIImageView = {
        let im = UIImageView()
        im.backgroundColor = Resources.Colors.basicColor
        return im
    }()
    
    private let trackAuthorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Resources.Colors.basicColorAlpha70
        label.text = "Big baby Tape и Aarne"
        return label
    }()
    
    private let trackTimeLimit: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Resources.Colors.basicColorAlpha70
        label.text = "01:15"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
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
        addSubview(trackAvatarImage)
        addSubview(trackAuthorName)
        addSubview(trackTimeLimit)
        addSubview(trackName)
    }
    
    private func setupConstraints() {
        trackAvatarImage.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(55)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        trackName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(70)
            make.top.equalTo(trackAvatarImage.snp.top).offset(5)
        }
        
        trackAuthorName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(70)
            make.bottom.equalTo(trackAvatarImage.snp.bottom).offset(-5)
        }
        
        trackTimeLimit.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(trackAuthorName.snp.bottom)
        }
    }
}

extension TrackTableViewCell {
    public func setupCell() {
        
    }
}
