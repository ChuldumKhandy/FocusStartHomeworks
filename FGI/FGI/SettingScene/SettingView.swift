//
//  SettingView.swift
//  FGI
//
//  Created by user on 07.01.2022.
//

import UIKit

protocol ISettingView: UIView {
    var signinHandler: ((_ login: String?, _ password: String?, _ passwordState: Bool) -> Void)? { get set }
}

final class SettingView: UIView {
    private let titleLabel = UILabel()
    private let loginTextView = UITextField()
    private let passwordTextView = UITextField()
    private let passwordStateSwitch = UISwitch()
    private var passwordState = false
    private let saveButton = UIButton()
    private let stackView = UIStackView()
    var signinHandler: ((_ login: String?, _ password: String?, _ passwordState: Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview()
        self.customizeStackView()
        self.customizeTextLabel()
        self.customizeTextFields()
        self.customizeSwitch()
        self.customizeButton()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingView: ISettingView {
}

private extension SettingView {
    func addSubview() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.stackView)
    }
    
    func customizeStackView() {
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .fill
        self.stackView.spacing = ViewConstraints.marginSmall.rawValue
        self.stackView.addArrangedSubview(self.loginTextView)
        self.stackView.addArrangedSubview(self.passwordTextView)
        self.stackView.addArrangedSubview(self.passwordStateSwitch)
        self.stackView.addArrangedSubview(self.saveButton)
    }
    
    func customizeTextLabel() {
        self.titleLabel.text = "Авторизация"
        self.titleLabel.font = .boldSystemFont(ofSize: FontSize.title.rawValue)
        self.titleLabel.textAlignment = .center
    }
    
    func customizeTextFields() {
        UITextField.appearance().borderStyle = .roundedRect
        UITextField.appearance().layer.cornerRadius = ViewConstraints.radius.rawValue
        UITextField.appearance().layer.masksToBounds = true
        UITextField.appearance().frame.size.height = ViewConstraints.heightButtons.rawValue
        self.loginTextView.placeholder = "Логин"
        self.passwordTextView.placeholder = "Пароль"
    }
    
    func customizeSwitch() {
        self.passwordStateSwitch.addTarget(self, action: #selector(self.isOnSwitch), for: .valueChanged)
    }
    
    @objc func isOnSwitch() {
        if self.passwordStateSwitch.isOn {
            self.passwordState = true
        }
    }
    
    func customizeButton() {
        self.saveButton.layer.cornerRadius = ViewConstraints.radius.rawValue
        self.saveButton.clipsToBounds = true
        self.saveButton.backgroundColor = .systemGray6
        self.saveButton.frame.size.height = ViewConstraints.heightButtons.rawValue
        self.saveButton.setTitleColor(.black, for: .normal)
        self.saveButton.setTitle("Сохранить", for: .normal)
        self.saveButton.addTarget(self, action: #selector(self.onSignClick), for: .touchUpInside)
    }

    @objc func onSignClick() {
        self.signinHandler?(self.loginTextView.text, self.passwordTextView.text, self.passwordState)
    }
    
    func setConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -ViewConstraints.top.rawValue).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.margin.rawValue).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: ViewConstraints.margin.rawValue).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
    }
}

