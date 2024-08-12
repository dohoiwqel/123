//
//  MainViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: MainTabBarCoordinator?

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .lightGray
            title = "Detail"
            
        }


}
