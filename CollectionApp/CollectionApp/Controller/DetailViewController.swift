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
    private let vStack = UIStackView()
    private let screenSize = UIScreen.main.bounds
    var detailCat: Cat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
}

extension DetailViewController {
    func configureVC() {
        self.view.backgroundColor = .white
        navigationController?.title = detailCat?.name
        configureLabels()
        configureIcon()
        configureButton()
        configureStack()
        self.view.addSubview(vStack)
        configureLayout()
    }
    
    func configureLabels() {
        let textDefault = UILabel.appearance()
        textDefault.textAlignment = .center
        textDefault.textColor = .black
        textDefault.adjustsFontSizeToFitWidth = true
        textDefault.lineBreakMode = .byWordWrapping
        textDefault.numberOfLines = 0
        
        titleLabel.text = detailCat?.name
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .purple
        
        decriptionLabel.text = detailCat?.description
        decriptionLabel.font = .italicSystemFont(ofSize: 15)
        decriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        decriptionLabel.backgroundColor = .blue
    }
    
    func configureIcon() {
        iconImageView.contentMode = .scaleAspectFit
        guard let iconName = detailCat?.iconName else { return }
        iconImageView.image = UIImage(named: iconName)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.frame.size.height = screenSize.height * 0.3
        iconImageView.backgroundColor = .red
    }
    
    func configureButton() {
        pawButton.setBackgroundImage(UIImage(named: "paw cat"), for: .normal)
        pawButton.setTitle("Дай пять!", for: .normal)
        pawButton.translatesAutoresizingMaskIntoConstraints = false
        pawButton.backgroundColor = .darkGray
    }
    
    func configureStack() {
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(iconImageView)
        vStack.addArrangedSubview(decriptionLabel)
        vStack.addArrangedSubview(pawButton)
        vStack.axis = .vertical
        vStack.spacing = 5
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.backgroundColor = .orange
    }
    
    func configureLayout() {
        
        
        self.vStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        self.vStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.vStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.vStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.iconImageView.setContentHuggingPriority(.init(255), for: .vertical)
    }
}
