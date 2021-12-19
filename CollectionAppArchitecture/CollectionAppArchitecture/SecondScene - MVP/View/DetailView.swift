//
//  DetailView.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import UIKit

protocol IDetailView: UIView {
    var onTouchedHandler: (() -> Void)? { get set }
    
    func setCatInformation(title: String, decription: String, iconName: String)
}

final class DetailView: UIView {
    var onTouchedHandler: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let decriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let pawButton = UIButton()
    private var screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

extension DetailView: IDetailView {
    func setCatInformation(title: String, decription: String, iconName: String) {
        self.titleLabel.text = title
        self.decriptionLabel.text = decription
        self.iconImageView.image = UIImage(named: iconName)
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
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.decriptionLabel.font = .italicSystemFont(ofSize: 15)
        self.decriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureIcon() {
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
    
    func configureLayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: screenSize.height / 8).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
    
        self.iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
    
        self.decriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.decriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0).isActive = true
        self.decriptionLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 6).isActive = true
        self.decriptionLabel.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        
        self.pawButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.pawButton.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 0).isActive = true
        self.pawButton.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        self.pawButton.widthAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
    }
}
