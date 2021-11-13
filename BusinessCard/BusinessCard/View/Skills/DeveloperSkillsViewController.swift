//
//  DeveloperViewController.swift
//  BusinessCard
//
//  Created by user on 13.11.2021.
//

import UIKit

class DeveloperSkillsViewController: UIViewController {

    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    let titleLabel = UILabel()
    let developerSkillsLabel = UILabel()
    let myGoalLabel = UILabel()
    let vStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
    }
}

extension DeveloperSkillsViewController {
    func configureVC() {
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
    
    func configureLabel() {
        titleLabel.text = DeveloperSkills.title
        titleLabel.font = UIFont.italicSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        developerSkillsLabel.text = DeveloperSkills.devSkills
        developerSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        myGoalLabel.text = DeveloperSkills.myGoal
        myGoalLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStack() {
        vStack.addArrangedSubview(developerSkillsLabel)
        vStack.addArrangedSubview(myGoalLabel)
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        self.vStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.height * 0.15).isActive = true
        self.vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
