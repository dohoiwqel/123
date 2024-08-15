//
//  AddTrackView.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 13.08.2024.
//

import Foundation
import UIKit
class AddTrackView: UIView {
    
    private let addingTrack: UILabel = {
       let label = UILabel()
        label.text = "  Добавление трека"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = Resources.Colors.basicColor
        return label
    }()
    
    public let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Resources.Colors.basicColor
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let authorNameTextField: UITextField = {
        let textField = UITextField()
        textField.makeBorders(width: 5)
        textField.makeBordersColor(color: Resources.Colors.basicCGColor)
        textField.makeRadius(radius: 15)
        // Изменение цвета текста плейсхолдера
        textField.attributedPlaceholder = NSAttributedString(
            string: "   Добавьте имя автора",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.basicColorAlpha70]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.textColor = Resources.Colors.basicColor
        return textField
    }()
    
    public let trackNameTextField: UITextField = {
        let textField = UITextField()
        textField.makeBorders(width: 5)
        textField.makeBordersColor(color: Resources.Colors.basicCGColor)
        textField.makeRadius(radius: 15)
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "   Добавьте название трека",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.basicColorAlpha70]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.textColor = Resources.Colors.basicColor
        return textField
    }()
    
    public let selectImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Загрузить изображение", for: .normal)
        button.makeRadius(radius: 15)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Resources.Colors.basicColor
        return button
    }()
    
    public let isImageLoaded: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(systemName: "checkmark.square")
        view.image = UIImage(systemName: "xmark.square")
//        view.tintColor = Resources.Colors.basicColor
        view.tintColor = Resources.Colors.redColor
        return view
    }()
    
    public let isTrackLoaded: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(systemName: "checkmark.square")
        view.image = UIImage(systemName: "xmark.square")
//        view.tintColor = Resources.Colors.basicColor
        view.tintColor = Resources.Colors.redColor
        return view
    }()
    
    public let selectTrackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Загрузить трек", for: .normal)
        button.makeRadius(radius: 15)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Resources.Colors.basicColor
        return button
    }()
    
    public let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.makeRadius(radius: 15)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Resources.Colors.basicColor
        return button
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
        addSubview(addingTrack)
        addSubview(avatarImageView)
        addSubview(authorNameTextField)
        addSubview(trackNameTextField)
        addSubview(selectImageButton)
        addSubview(selectTrackButton)
        addSubview(isImageLoaded)
        addSubview(isTrackLoaded)
        addSubview(loadButton)
    }
    
    private func setupConstraints() {
        addingTrack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(addingTrack.snp.bottom).offset(15)
        }
        
        authorNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(46)
        }
        
        trackNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(authorNameTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(46)
        }
        
        selectImageButton.snp.makeConstraints { make in
            make.top.equalTo(trackNameTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-100)
            make.height.equalTo(46)
        }
        
        selectTrackButton.snp.makeConstraints { make in
            make.top.equalTo(selectImageButton.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-100)
            make.height.equalTo(46)
        }
        
        isImageLoaded.snp.makeConstraints { make in
            make.centerY.equalTo(selectImageButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(40)
        }
        
        isTrackLoaded.snp.makeConstraints { make in
            make.centerY.equalTo(selectTrackButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(40)
        }
        
        loadButton.snp.makeConstraints { make in
            make.top.equalTo(selectTrackButton.snp.bottom).offset(100)
            make.height.equalTo(46)
            make.centerX.equalToSuperview()
            make.width.equalTo(selectTrackButton.snp.width)
        }
    }
}
