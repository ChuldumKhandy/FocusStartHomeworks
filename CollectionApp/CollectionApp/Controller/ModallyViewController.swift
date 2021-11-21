//
//  ModallyViewController.swift
//  CollectionApp
//
//  Created by user on 20.11.2021.
//

import UIKit

final class ModallyViewController: UIViewController {
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let catImageView = UIImageView()
    private let twButton = UIButton()
    private let instButton = UIButton()
    private var screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ModallyViewController.configureLayout),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
}

private extension ModallyViewController {
    func configureVC() {
        self.view.backgroundColor = .white
        self.configureLabels()
        self.view.addSubview(titleLabel)
        
        self.configureIcon()
        self.view.addSubview(catImageView)
        self.view.addSubview(iconImageView)
        
        self.configureButtons()
        self.view.addSubview(twButton)
        self.view.addSubview(instButton)
        
        configureLayout()
    }
    
    func configureLabels() {
        self.titleLabel.text = "Иллюстрации взяты у кошачьего хужодника ぢゅの (Juno)"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .black
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureIcon() {
        self.iconImageView.image = UIImage(named: "iconcat")
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.clipsToBounds = true
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.catImageView.image = UIImage(named: "cat")
        self.catImageView.contentMode = .scaleAspectFit
        self.catImageView.clipsToBounds = true
        self.catImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButtons() {
        self.twButton.setBackgroundImage(UIImage(named: "icontwitter"), for: .normal)
        self.twButton.contentMode = .scaleAspectFit
        self.twButton.clipsToBounds = true
        self.twButton.addTarget(self, action: #selector(urlTwit(sender:)), for: .touchUpInside)
        self.twButton.translatesAutoresizingMaskIntoConstraints = false

        self.instButton.setBackgroundImage(UIImage(named: "iconInstagram"), for: .normal)
        self.instButton.contentMode = .scaleAspectFit
        self.instButton.clipsToBounds = true
        self.instButton.addTarget(self, action: #selector(urlInst(sender:)), for: .touchUpInside)
        self.instButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func urlInst(sender: Any){
        if let url = URL(string: "https://www.instagram.com/mofu_sand/") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @objc func urlTwit(sender: Any){
        if let url = URL(string: "https://twitter.com/mofu_sand") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @objc func configureLayout() {
        screenSize = UIScreen.main.bounds
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        
        self.iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        
        self.instButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.instButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -screenSize.width / 8).isActive = true
        self.instButton.heightAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        self.instButton.widthAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        
        self.twButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.twButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: screenSize.width / 8).isActive = true
        self.twButton.heightAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        self.twButton.widthAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true

        self.catImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.catImageView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0).isActive = true
        self.catImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 4).isActive = true
        self.catImageView.widthAnchor.constraint(equalToConstant: screenSize.height / 4).isActive = true
    }
}
