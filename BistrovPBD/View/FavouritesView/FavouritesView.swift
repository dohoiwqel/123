//
//  FavouritesView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit

class FavouritesView: UIView {
    
    private let favouritesHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "Избранные"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = Resources.Colors.basicColor
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
        setupSubviews()
        setupConstraits()
    }
    
    private func setupSubviews() {
        addSubview(favouritesHeaderLabel)
    }
    
    private func setupConstraits() {
        favouritesHeaderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
    }
}
