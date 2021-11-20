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
    private var screenSize = UIScreen.main.bounds
    private var vrConstraint = [NSLayoutConstraint]()
    private var hrConstraint = [NSLayoutConstraint]()
    var detailCat: Cat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DetailViewController.configureLayout),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
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
        self.pawButton.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        self.pawButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func tapButton(sender: UIButton) {
        self.present(ModallyViewController(), animated: true, completion: nil)
    }
    
    func configureVerticalLayout() {
        NSLayoutConstraint.deactivate(hrConstraint)
        self.vrConstraint = [
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: screenSize.height / 8),
            self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8),
            self.titleLabel.widthAnchor.constraint(equalToConstant: screenSize.width),
    
            self.iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3),
            self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.width),
        
            self.decriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.decriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0),
            self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 6),
            self.decriptionLabel.widthAnchor.constraint(equalToConstant: screenSize.width),
        
            self.pawButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0),
            self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height / 8),
            self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height / 8)
        ]
        NSLayoutConstraint.activate(vrConstraint)
    }
    
    func configureHorizontalLayout() {
        NSLayoutConstraint.deactivate(vrConstraint)
        self.hrConstraint = [
            self.iconImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: screenSize.height / 8),
            self.iconImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height * 0.75),
            self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.height * 0.75),
        
            self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height / 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8),
            
            self.decriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            self.decriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0),
            self.decriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 4),
            
            self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0),
            self.pawButton.centerXAnchor.constraint(equalTo: decriptionLabel.centerXAnchor),
            self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height * 0.375),
            self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height * 0.375)
        ]
        NSLayoutConstraint.activate(hrConstraint)
    }
    
    @objc func configureLayout() {
        screenSize = UIScreen.main.bounds
        if UIDevice.current.orientation.isLandscape {
            configureHorizontalLayout()
        } else {
            configureVerticalLayout()
        }
    }
}
