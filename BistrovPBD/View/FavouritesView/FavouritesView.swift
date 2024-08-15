//
//  FavouritesView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit

class FavouritesView: UIView {
    
    //MARK: Properties
    private let favouritesHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "Избранные"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public  let favouritesTableView = UITableView()
    
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
        setupConstraits()
    }
    
    private func setupSubviews() {
        addSubview(favouritesHeaderLabel)
        addSubview(favouritesTableView)
    }
    
    private func setupConstraits() {
        favouritesHeaderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        favouritesTableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(100)
            make.top.equalTo(favouritesHeaderLabel.snp.bottom).offset(30)
        }
    }
}
