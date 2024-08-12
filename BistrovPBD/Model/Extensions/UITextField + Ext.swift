//
//  UITextField + Ext.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit

extension UITextField: UITextFieldDelegate {
    
    
    func createBasicTextField(text: String) {
        // Устанавливаем отступ и цвет placeholder
        let paragraphStyle = NSMutableParagraphStyle()
        let placeholderColor = Resources.Colors.basicColor.withAlphaComponent(0.7)
        paragraphStyle.firstLineHeadIndent = 25
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .paragraphStyle: paragraphStyle
        ]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
        self.attributedPlaceholder = attributedPlaceholder
        
        self.layer.borderColor = Resources.Colors.basicCGColor
        self.backgroundColor = .clear
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 16
        
        // Устанавливаем делегат для обработки событий текстового поля
        self.delegate = self
        // Устанавливаем цвет текста и отступ для текста
        paragraphStyle.firstLineHeadIndent = 25

        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Resources.Colors.basicColor,  // Цвет текста
            .paragraphStyle: paragraphStyle
        ]

        self.defaultTextAttributes = textAttributes
    }
    
    func setParagraphStyle(width: CGFloat) {
        guard let placeholder = self.placeholder else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = width
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: Resources.Colors.basicColorAlpha70
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
    }
    
    func setPlaceholderColor(_ color: UIColor) {
            guard let placeholder = self.placeholder else { return }
            
            let placeholderAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: color
            ]
            
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        }
}

