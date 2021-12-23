//
//  InfoView.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

protocol IInfoView: UIView {
}

final class InfoView: UIView {
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.scrollView)
        self.addSubview(self.titleLabel)
        self.customizeScrollView()
        self.customizeLable()
        self.customizeStackView()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoView: IInfoView {
}

private extension InfoView {
    func customizeLable() {
        self.titleLabel.text = InfoText.title.rawValue
        self.titleLabel.font = .boldSystemFont(ofSize: 20)
        self.titleLabel.textAlignment = .left
        self.titleLabel.numberOfLines = 0
    }
    
    func customizeScrollView() {
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.addSubview(self.stackView)
        self.scrollView.contentSize = self.stackView.frame.size
    }
    
    func customizeStackView() {
        let textDefault = UILabel.appearance()
        textDefault.textAlignment = .left
        textDefault.textColor = UIColor.black
        textDefault.adjustsFontSizeToFitWidth = true
        textDefault.lineBreakMode = .byWordWrapping
        textDefault.numberOfLines = 0
        
        let annotation = UILabel()
        let calculationIndex = UILabel()
        let resultFGI = UILabel()
        let conclusion = UILabel()
        annotation.text = InfoText.annotation.rawValue
        calculationIndex.text = InfoText.calculationIndex.rawValue
        resultFGI.text = InfoText.resultFGI.rawValue
        conclusion.text = InfoText.conclusion.rawValue
        
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .fill
        self.stackView.spacing = 8
        self.stackView.addArrangedSubview(annotation)
        self.stackView.addArrangedSubview(calculationIndex)
        self.stackView.addArrangedSubview(resultFGI)
        self.stackView.addArrangedSubview(conclusion)
    }
    
    func setConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 45).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
