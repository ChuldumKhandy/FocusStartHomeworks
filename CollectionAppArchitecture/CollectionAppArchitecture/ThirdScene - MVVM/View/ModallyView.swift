//
//  ModallyView.swift
//  CollectionAppArchitecture
//
//  Created by user on 28.11.2021.
//

import UIKit

final class ModallyView: UIView {
    private var modallyViewModel = ModallyViewModel()
    var onTouchedHandler: (() -> Void)?
    var onTouchedUrlInstHandler: (() -> Void)?
    var onTouchedUrlTwitHandler: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let catImageView = UIImageView()
    private let twButton = UIButton()
    private let instButton = UIButton()
    private let backButton = UIButton()
    private var screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
        
        self.modallyViewModel.dataModally.setNotify { [weak self] imageName in
            self?.catImageView.image = UIImage(named: imageName)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ModallyView {
    func configureView() {
        self.backgroundColor = .white
        self.configureLabels()
        self.addSubview(titleLabel)

        self.configureIcon()
        self.addSubview(catImageView)
        self.addSubview(iconImageView)

        self.configureButtons()
        self.addSubview(twButton)
        self.addSubview(instButton)
        self.addSubview(backButton)

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

        self.backButton.setTitle(" Назад ", for: .normal)
        self.backButton.setTitleColor(.black, for: .normal)
        self.backButton.backgroundColor = .systemGray5
        self.backButton.layer.cornerRadius = 10
        self.backButton.clipsToBounds = true
        self.backButton.addTarget(self, action: #selector(dismiss(sender:)), for: .touchUpInside)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func urlInst(sender: Any){
        self.onTouchedUrlInstHandler?()
    }

    @objc func urlTwit(sender: Any){
        self.onTouchedUrlTwitHandler?()
    }

    @objc func dismiss(sender: Any){
        self.onTouchedHandler?()
    }

    @objc func configureLayout() {
        screenSize = UIScreen.main.bounds
        
        self.backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: screenSize.height / 32).isActive = true
        self.backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backButton.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: screenSize.height / 8).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true

        self.iconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true

        self.instButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.instButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -screenSize.width / 8).isActive = true
        self.instButton.heightAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        self.instButton.widthAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true

        self.twButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.twButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: screenSize.width / 8).isActive = true
        self.twButton.heightAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true
        self.twButton.widthAnchor.constraint(equalToConstant: screenSize.height / 16).isActive = true

        self.catImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.catImageView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: screenSize.height / 32).isActive = true
        self.catImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 4).isActive = true
        self.catImageView.widthAnchor.constraint(equalToConstant: screenSize.height / 4).isActive = true
    }
}
