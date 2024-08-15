//
//  FavouritesViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation
import UIKit

class FavouritesViewController: UIViewController {
    
    let favouritesView = FavouritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(favouritesView)
        
        favouritesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
