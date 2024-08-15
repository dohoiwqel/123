//
//  FeedView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit

class FeedView: UIView {
    
    //MARK: Properties
    private let tracksHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "Треки"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let addTrackButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = Resources.Colors.basicColor
        return button
    }()
    
    public let tracksTableView = UITableView()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func configure() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(tracksHeaderLabel)
        addSubview(tracksTableView)
        addSubview(addTrackButton)
    }
    
    private func setupConstraints() {
        tracksHeaderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        tracksTableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(100)
            make.top.equalTo(tracksHeaderLabel.snp.bottom).offset(30)
        }
        
        addTrackButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.trailing.equalToSuperview().offset(-18)
            make.centerY.equalTo(tracksHeaderLabel.snp.centerY)
        }
        
    }
    
}
