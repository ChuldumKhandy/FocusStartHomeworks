//
//  DetailViewController.swift
//  CollectionApp
//
//  Created by user on 18.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    private let titleLabel = UILabel()
    private let decriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let pawButton = UIButton()
    private let screenSize = UIScreen.main.bounds
    var detailCat: Cat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(rotateLayout),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension DetailViewController {
    func configureVC() {
        self.view.backgroundColor = .white
        self.configureLabels()
        self.view.addSubview(titleLabel)
        self.view.addSubview(decriptionLabel)
        self.configureIcon()
        self.view.addSubview(iconImageView)
        self.configureButton()
        self.view.addSubview(pawButton)
        self.configureLayout()
    }
    
    func configureLabels() {
        let textDefault = UILabel.appearance()
        textDefault.textAlignment = .center
        textDefault.textColor = .black
        textDefault.adjustsFontSizeToFitWidth = true
        textDefault.lineBreakMode = .byWordWrapping
        textDefault.numberOfLines = 0
        
        self.titleLabel.text = detailCat?.name
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.decriptionLabel.text = detailCat?.description
        self.decriptionLabel.font = .italicSystemFont(ofSize: 15)
        self.decriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureIcon() {
        guard let iconName = detailCat?.iconName else { return }
        self.iconImageView.image = UIImage(named: iconName)
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.clipsToBounds = true
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButton() {
        self.pawButton.setBackgroundImage(UIImage(named: "paw cat"), for: .normal)
        self.pawButton.contentMode = .scaleAspectFit
        self.pawButton.clipsToBounds = true
        self.pawButton.setTitle("Дай пять!", for: .normal)
        self.pawButton.setTitleColor(.black, for: .normal)
        self.pawButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureVerticalLayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: screenSize.height / 8).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        
        self.iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        
        self.decriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.decriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0).isActive = true
        self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 6).isActive = true
        self.decriptionLabel.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        
        self.pawButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0).isActive = true
        self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
    }
    
    func configureHorizontalLayout() {
        self.iconImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: screenSize.height / 8).isActive = true
        self.iconImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.width * 0.5).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.5).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height / 8).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        
        self.decriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        self.decriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0).isActive = true
        self.decriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 4).isActive = true
        
        self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0).isActive = true
        self.pawButton.centerXAnchor.constraint(equalTo: decriptionLabel.centerXAnchor).isActive = true
        self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height * 0.375).isActive = true
        self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height * 0.375).isActive = true
    }
    
    func configureLayout() {
        if UIDevice.current.orientation.isLandscape {
            configureHorizontalLayout()
        } else {
            configureVerticalLayout()
        }
    }
    
    @objc func rotateLayout() {
        if UIDevice.current.orientation.isLandscape {
            configureHorizontalLayout()
        } else {
            configureVerticalLayout()
        }
    }
}
