//
//  PersonalInfoViewController.swift
//  BusinessCard
//
//  Created by user on 13.11.2021.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    let screenSize = UIScreen.main.bounds
    let backgroundImage = UIImageView()
    let avatarImageView = UIImageView()
    let textDefault = UILabel.appearance()
    let titleLabel = UILabel()
    let aboutMeLabel = UILabel()
    let educationInfoLabel = UILabel()
    let homeInfoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
    }
}

extension PersonalInfoViewController {
    func configureVC() {
        backgroundImage.frame = screenSize
        backgroundImage.image = UIImage(named: "backgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.confifureAvatar()
        self.view.addSubview(self.avatarImageView)
        
        self.configureLabel()
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.aboutMeLabel)
        self.view.addSubview(self.educationInfoLabel)
        self.view.addSubview(self.homeInfoLabel)
        
        self.configureLayout()
    }
    
    func confifureAvatar() {
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFill
        avatarImageView.layer.cornerRadius = screenSize.height * 0.1
        avatarImageView.clipsToBounds = true
        avatarImageView.image = UIImage(named: "itsme")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLabel() {
        textDefault.textAlignment = .center
        textDefault.lineBreakMode = .byWordWrapping
        textDefault.numberOfLines = 0
        
        titleLabel.text = PersonalInformation.title
        titleLabel.font = UIFont.italicSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aboutMeLabel.text = PersonalInformation.aboutMe
        aboutMeLabel.adjustsFontSizeToFitWidth = true
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        educationInfoLabel.text = PersonalInformation.educationInfo
        educationInfoLabel.adjustsFontSizeToFitWidth = true
        educationInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        homeInfoLabel.text = PersonalInformation.homeInfo
        homeInfoLabel.sizeToFit()
        homeInfoLabel.adjustsFontSizeToFitWidth = true
        homeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureLayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        self.avatarImageView.widthAnchor.constraint(equalToConstant: screenSize.height * 0.2).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalToConstant: screenSize.height * 0.2).isActive = true
        self.avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height * 0.05).isActive = true
        
        self.aboutMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.aboutMeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        self.aboutMeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.aboutMeLabel.heightAnchor.constraint(equalToConstant: screenSize.height * 0.15).isActive = true
        self.aboutMeLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: screenSize.height * 0.05).isActive = true
        
        self.educationInfoLabel.widthAnchor.constraint(equalTo: aboutMeLabel.widthAnchor).isActive = true
        self.educationInfoLabel.heightAnchor.constraint(equalTo: aboutMeLabel.heightAnchor).isActive = true
        self.educationInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.educationInfoLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 0).isActive = true
        
        self.homeInfoLabel.widthAnchor.constraint(equalTo: educationInfoLabel.widthAnchor).isActive = true
        self.homeInfoLabel.heightAnchor.constraint(equalTo: educationInfoLabel.heightAnchor).isActive = true
        self.homeInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.homeInfoLabel.topAnchor.constraint(equalTo: educationInfoLabel.bottomAnchor, constant: 0).isActive = true
    }
}
