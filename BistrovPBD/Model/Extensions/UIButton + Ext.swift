//
//  UIButton + Ext.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
extension UIButton {
    
    public func createBasicButton(text: String) {
        self.setTitleColor(Resources.Colors.basicColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
}
