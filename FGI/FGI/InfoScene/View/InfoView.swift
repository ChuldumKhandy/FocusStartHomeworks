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
        self.titleLabel.textAlignment = .center
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
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstraints.top.rawValue).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.margin.rawValue).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewConstraints.bottom.rawValue).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalToConstant: self.frame.size.width - ViewConstraints.left.rawValue * 2).isActive = true
    }
}
