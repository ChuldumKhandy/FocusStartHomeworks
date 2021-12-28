//
//  LogInView.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

protocol ILogInView: UIView {
    var loginHandler: ((_ login: String?, _ password: String?) -> Void)? { get set }
    var signinHandler: ((_ login: String?, _ password: String?) -> Void)? { get set }
}

final class LogInView: UIView {
    private let titleLabel = UILabel()
    private let loginTextView = UITextField()
    private let passwordTextView = UITextField()
    private let loginButton = UIButton()
    private let signinButton = UIButton()
    private let stackView = UIStackView()
    
    var loginHandler: ((_ login: String?, _ password: String?) -> Void)?
    var signinHandler: ((_ login: String?, _ password: String?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview()
        self.customizeStackView()
        self.customizeTextLabel()
        self.customizeTextFields()
        self.customizeButtons()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LogInView: ILogInView {
}

private extension LogInView {
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
        self.stackView.addArrangedSubview(self.loginButton)
        self.stackView.addArrangedSubview(self.signinButton)
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
    
    func customizeButtons() {
        UIButton.appearance().layer.cornerRadius = ViewConstraints.radius.rawValue
        UIButton.appearance().clipsToBounds = true
        UIButton.appearance().backgroundColor = .systemGray6
        UIButton.appearance().frame.size.height = ViewConstraints.heightButtons.rawValue
        UIButton.appearance().setTitleColor(.black, for: .normal)
        self.loginButton.setTitle("Авторизоваться", for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.onLoginClick), for: .touchUpInside)
        self.signinButton.setTitle("Зарегистрироваться", for: .normal)
        self.signinButton.addTarget(self, action: #selector(self.onSignClick), for: .touchUpInside)
    }
    
    @objc func onLoginClick() {
        self.loginHandler?(self.loginTextView.text, self.passwordTextView.text)
    }

    @objc func onSignClick() {
        self.signinHandler?(self.loginTextView.text, self.passwordTextView.text)
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
