//
//  UIView + Ext.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
extension UIView {
    func roundTopCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func makeRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func makeBorders(width: CGFloat) {
        self.layer.borderWidth = width
    }
    
    func makeBordersColor(color: CGColor) {
        self.layer.borderColor = color
    }
    
    func deleteBorders() {
        self.layer.borderWidth = 0
    }
}
