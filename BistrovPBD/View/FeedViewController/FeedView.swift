//
//  FeedView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import UIKit

class FeedView: UIView {
    
    private let tracksHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "Треки"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let tracksTableView: UITableView = {
        let tv = UITableView()
        
        return tv
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
        addSubview(tracksHeaderLabel)
        addSubview(tracksTableView)
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
            make.bottom.equalToSuperview().inset(200)
            make.top.equalTo(tracksHeaderLabel.snp.bottom).offset(30)
        }
        tracksTableView.backgroundColor = .white
    }
    
}
