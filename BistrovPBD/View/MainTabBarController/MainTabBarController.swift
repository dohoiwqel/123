//
//  MainTabBarController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

//    weak var mainDelegate: MainTabBarControllerDelegate?
    weak var coordinator: MainTabBarCoordinator!
    
    private let customTabBarView: UIView = {
        let view = UIView()
        view.roundTopCorners(radius: 21)
        view.makeBordersColor(color: Resources.Colors.basicCGColor)
        view.makeBorders(width: 3)
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        generateTabBar()
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        tabBar.unselectedItemTintColor = Resources.Colors.basicColorAlpha70
        tabBar.tintColor = Resources.Colors.basicColor
        view.backgroundColor = .black
        selectedIndex = 0
        
    }
    
    private func setupSubviews() {
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    private func setupConstraints() {
        customTabBarView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(10)
            make.width.equalTo(393)
            make.height.equalTo(110)
            make.centerX.equalToSuperview()
        }
    }
    
}


extension MainTabBarController {
    private func generateTabBar() {
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = .none
            
            // Настройка атрибутов текста для обычного состояния
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: Resources.Colors.basicColorAlpha70,
                .font: UIFont.systemFont(ofSize: 16)
            ]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            
            // Настройка атрибутов текста для выбранного состояния
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: Resources.Colors.basicColor,
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }
}

