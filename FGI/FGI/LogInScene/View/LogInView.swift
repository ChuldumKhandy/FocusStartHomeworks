//
//  LogInView.swift
//  FGI
//
//  Created by user on 27.12.2021.
//

import UIKit

protocol ILogInView: UIView {
    var checkPasswordHandler: ((String?) -> Void)? { get set }
    var setName: ((String) -> Void)? { get set }
}

final class LogInView: UIView {
    private let titleLabel = UILabel()
    private let passwordTextView = StandartTextField()
    private let loginButton = StandartButton()
    private let stackView = UIStackView()
    var checkPasswordHandler: ((String?) -> Void)?
    var setName: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview()
        self.customizeStackView()
        self.customizeTextLabel()
        self.customizeTextField()
        self.customizeButtons()
        self.setConstraints()
        self.setName = { [weak self] login in
            if login == "" {
                self?.titleLabel.text = "Добрый день"
            } else {
                self?.titleLabel.text = "Добрый день, \(login)"
            }
        }
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
        self.stackView.addArrangedSubview(self.passwordTextView)
        self.stackView.addArrangedSubview(self.loginButton)
    }
    
    func customizeTextLabel() {
        self.titleLabel.font = .boldSystemFont(ofSize: FontSize.title.rawValue)
        self.titleLabel.textAlignment = .center
    }
    
    func customizeTextField() {
        self.passwordTextView.placeholder = "Пароль"
    }
    
    func customizeButtons() {
        self.loginButton.setTitle("Войти", for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.onLoginClick), for: .touchUpInside)
    }
    
    @objc func onLoginClick() {
        self.checkPasswordHandler?(self.passwordTextView.text)
    }
    
    func setConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -ViewConstraints.margin.rawValue).isActive = true
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
