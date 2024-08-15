//
//  AddTrackViewController.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation
import UIKit
import MobileCoreServices // Для типов документов
import AVFoundation // Для работы с аудио и видео

class AddTrackViewController: UIViewController {
    
    //MARK: Properties
    public weak var coordinator: FeedCoordinator?
    public var authorNameTextField: UITextField!
    public var trackNameTextField: UITextField!
    public var avatarImageView: UIImageView!
    public var selectImageButton: UIButton!
    public var selectTrackButton: UIButton!
    public var saveButton: UIButton!
    public var dismissButton: UIButton!
    public var selectedImage: UIImage?
    public var trackData: Data?
    public var trackDuration: String = ""
    
    public let addTrackView = AddTrackView()
    public let viewModel = AddTrackViewModel()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configure()
    }
    
    private func configure() {
        setupViews()
        setupUI()
        setupButtons()
    }
    
    private func setupUI() {
        view.addSubview(addTrackView)
        
        addTrackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupViews() {
        self.authorNameTextField = addTrackView.authorNameTextField
        self.trackNameTextField = addTrackView.trackNameTextField
        self.avatarImageView = addTrackView.avatarImageView
        self.selectImageButton = addTrackView.selectImageButton
        self.selectTrackButton = addTrackView.selectTrackButton
        self.saveButton = addTrackView.loadButton
        self.dismissButton = addTrackView.dismissButton
    }
    
    
}

