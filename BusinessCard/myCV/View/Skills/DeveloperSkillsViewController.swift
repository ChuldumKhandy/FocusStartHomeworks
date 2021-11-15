//
//  DeveloperViewController.swift
//  BusinessCard
//
//  Created by user on 13.11.2021.
//

import UIKit

final class DeveloperSkillsViewController: UIViewController {

    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    private let titleLabel = UILabel()
    private let developerSkillsLabel = UILabel()
    private let myGoalLabel = UILabel()
    private let vStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
    }
}

extension DeveloperSkillsViewController {
    private func configureVC() {
        backgroundImage.image = UIImage(named: "backgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        configureLabel()
        self.view.addSubview(titleLabel)
        self.view.addSubview(developerSkillsLabel)
        self.view.addSubview(myGoalLabel)
        
        configureStack()
        self.view.addSubview(vStack)
        
        self.configureLayout()
    }
    
    private func configureLabel() {
        titleLabel.text = DeveloperSkills.title.rawValue
        titleLabel.font = UIFont.italicSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        developerSkillsLabel.text = DeveloperSkills.devSkills.rawValue
        developerSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        myGoalLabel.text = DeveloperSkills.myGoal.rawValue
        myGoalLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStack() {
        vStack.addArrangedSubview(developerSkillsLabel)
        vStack.addArrangedSubview(myGoalLabel)
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        self.vStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.height * 0.15).isActive = true
        self.vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
