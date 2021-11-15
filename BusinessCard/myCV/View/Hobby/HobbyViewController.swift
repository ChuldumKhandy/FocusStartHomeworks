//
//  HobbyViewController.swift
//  BusinessCard
//
//  Created by user on 13.11.2021.
//

import UIKit

final class HobbyViewController: UIViewController {

    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    private let titleLabel = UILabel()
    private let textMyHobbyLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
    }
}

extension HobbyViewController {
    private func configureVC() {
        backgroundImage.image = UIImage(named: "backgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        configureLabel()
        self.view.addSubview(titleLabel)
        self.view.addSubview(textMyHobbyLabel)
        
        configureIcon()
        self.view.addSubview(iconImageView)
        
        self.configureLayout()
    }
    
    private func configureLabel() {
        titleLabel.text = Hobby.title.rawValue
        titleLabel.font = UIFont.italicSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textMyHobbyLabel.text = Hobby.myHobby.rawValue
        textMyHobbyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureIcon() {
        iconImageView.contentMode = UIView.ContentMode.scaleAspectFit
        iconImageView.image = UIImage(named: "hamster")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        self.textMyHobbyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.height * 0.15).isActive = true
        self.textMyHobbyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.textMyHobbyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        self.iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.1).isActive = true
    }
}

