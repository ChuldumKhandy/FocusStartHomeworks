//
//  DetailView.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import UIKit

class DetailView: UIView {
    var onTouchedHandler: (() -> Void)?
    private var presenter: DetailPresenter?
    
    private let titleLabel = UILabel()
    private let decriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let pawButton = UIButton()
    private var screenSize = UIScreen.main.bounds
    private var vrConstraint = [NSLayoutConstraint]()
    private var hrConstraint = [NSLayoutConstraint]()
    
    func loadView(controller: DetailViewController, presenter: DetailPresenter) {
        self.presenter = presenter
        self.presenter?.loadPresenter(controller: controller, view: self)
    }
    
    func configureView() {
        self.backgroundColor = .white
        self.configureLabels()
        self.addSubview(titleLabel)
        self.addSubview(decriptionLabel)
        self.configureIcon()
        self.addSubview(iconImageView)
        self.configureButton()
        self.addSubview(pawButton)
        self.configureLayout()
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

private extension DetailView {
    func configureLabels() {
        let textDefault = UILabel.appearance()
        textDefault.textAlignment = .center
        textDefault.textColor = .black
        textDefault.adjustsFontSizeToFitWidth = true
        textDefault.lineBreakMode = .byWordWrapping
        textDefault.numberOfLines = 0
        
        self.titleLabel.text = presenter?.getTitle()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.decriptionLabel.text = presenter?.getDescription()
        self.decriptionLabel.font = .italicSystemFont(ofSize: 15)
        self.decriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureIcon() {
        if let iconName = presenter?.getIconName() {
            self.iconImageView.image = UIImage(named: iconName)
        }
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
        self.onTouchedHandler?()
    }
    
    func configureVerticalLayout() {
        NSLayoutConstraint.deactivate(hrConstraint)
        self.vrConstraint = [
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: screenSize.height / 8),
            self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8),
            self.titleLabel.widthAnchor.constraint(equalToConstant: screenSize.width),
    
            self.iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3),
            self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.width),
        
            self.decriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.decriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0),
            self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 6),
            self.decriptionLabel.widthAnchor.constraint(equalToConstant: screenSize.width),
        
            self.pawButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0),
            self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height / 8),
            self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height / 8)
        ]
        NSLayoutConstraint.activate(vrConstraint)
    }
    
    func configureHorizontalLayout() {
        NSLayoutConstraint.deactivate(vrConstraint)
        self.hrConstraint = [
            self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: screenSize.height / 8),
            self.iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height * 0.75),
            self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.height * 0.75),
        
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: screenSize.height / 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8),
            
            self.decriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            self.decriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0),
            self.decriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 4),
            
            self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0),
            self.pawButton.centerXAnchor.constraint(equalTo: decriptionLabel.centerXAnchor),
            self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height * 0.375),
            self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height * 0.375)
        ]
        NSLayoutConstraint.activate(hrConstraint)
    }
}
