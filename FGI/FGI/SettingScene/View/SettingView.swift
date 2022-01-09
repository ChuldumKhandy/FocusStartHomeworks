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
    private let loginTextView = StandartTextField()
    private let passwordTextView = StandartTextField()
    private let passwordStateSwitch = UISwitch()
    private var passwordState = false
    private let saveButton = StandartButton()
    private let stackView = UIStackView()
    var signinHandler: ((_ login: String?, _ password: String?, _ passwordState: Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview()
        self.customizeStackView()
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
        self.addSubview(self.stackView)
    }
    
    func customizeStackView() {
        let title = UILabel()
        title.text = "Включить пароль: "
        let subStackView = UIStackView()
        subStackView.axis = .horizontal
        subStackView.distribution = .equalSpacing
        subStackView.alignment = .fill
        subStackView.spacing = ViewConstraints.marginSmall.rawValue
        subStackView.addArrangedSubview(title)
        subStackView.addArrangedSubview(self.passwordStateSwitch)
        
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .fill
        self.stackView.spacing = ViewConstraints.marginSmall.rawValue
        self.stackView.addArrangedSubview(self.loginTextView)
        self.stackView.addArrangedSubview(self.passwordTextView)
        self.stackView.addArrangedSubview(subStackView)
        self.stackView.addArrangedSubview(self.saveButton)
    }
    
    func customizeTextFields() {
        self.loginTextView.placeholder = "Ваше имя"
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
        self.saveButton.setTitle("Сохранить", for: .normal)
        self.saveButton.addTarget(self, action: #selector(self.onSignClick), for: .touchUpInside)
    }

    @objc func onSignClick() {
        self.signinHandler?(self.loginTextView.text, self.passwordTextView.text, self.passwordState)
    }
    
    func setConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstraints.top.rawValue).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
    }
}

