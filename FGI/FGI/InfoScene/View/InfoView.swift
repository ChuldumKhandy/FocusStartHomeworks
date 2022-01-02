//
//  InfoView.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

protocol IInfoView: UIView {
    var tappedOnLabelHandler: (() -> Void)? { get set }
    var backHandler: (() -> Void)? { get set }
}

final class InfoView: UIView {
    private let scrollView = UIScrollView(frame: .zero)
    private let backButton = UIButton()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let annotation = UILabel()
    private let calculationIndex = UILabel()
    private let resultFGI = UILabel()
    private let conclusion = UILabel()
    var tappedOnLabelHandler: (() -> Void)?
    var backHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.scrollView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.backButton)
        self.customizeScrollView()
        self.customizeLables()
        self.customizeButton()
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
    func customizeButton() {
        self.backButton.backgroundColor = .white
        self.backButton.frame.size.height = ViewConstraints.heightButtons.rawValue
        self.backButton.tintColor = .black
        self.backButton.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
        self.backButton.addTarget(self, action: #selector(self.backDiagramVC), for: .touchUpInside)
    }
    
    @objc func backDiagramVC() {
        self.backHandler?()
    }
    
    func customizeLables() {
        UILabel.appearance().textAlignment = .natural
        UILabel.appearance().textColor = .black
        UILabel.appearance().numberOfLines = 0
        UILabel.appearance().lineBreakMode = .byWordWrapping

        self.titleLabel.text = InfoText.title.rawValue
        self.titleLabel.font = .boldSystemFont(ofSize: FontSize.title.rawValue)
        self.titleLabel.textAlignment = .center
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tappedOnLabel(_:)))
        self.annotation.isUserInteractionEnabled = true
        self.annotation.addGestureRecognizer(tapGesture)
       
        self.annotation.attributedText = self.annotationStr()
        self.calculationIndex.attributedText = self.calculationIndexStr()
        self.resultFGI.attributedText = self.resultFGIStr()
        self.conclusion.text = InfoText.conclusion.rawValue
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = annotation.text else { return }
        let urlRange = (text as NSString).range(of: InfoText.url.rawValue)
        if gesture.didTapAttributedTextInLabel(label: self.annotation, inRange: urlRange) {
            self.tappedOnLabelHandler?()
        }
    }
    
    func annotationStr() -> NSMutableAttributedString {
        let annotationAttr = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: FontSize.large.rawValue)]
        let urlAttr = NSMutableAttributedString(string: InfoText.url.rawValue)
        urlAttr.addAttribute(.link,
                             value: "https://money.cnn.com/data/fear-and-greed/",
                             range: urlAttr.mutableString.range(of: InfoText.url.rawValue))
        let annotationStr = NSMutableAttributedString(string: InfoText.annotation1.rawValue,
                                                      attributes: annotationAttr as [NSAttributedString.Key : Any])
        annotationStr.append(urlAttr)
        annotationStr.append(NSAttributedString(string: InfoText.annotation2.rawValue,
                                                attributes: annotationAttr as [NSAttributedString.Key : Any]))
        return annotationStr
    }
    
    func calculationIndexStr() -> NSMutableAttributedString {
        let titleAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.medium.rawValue,
                                                                        weight: UIFont.Weight(rawValue: FontSize.weight.rawValue))]
        let calculationIndexAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.medium.rawValue)]
        let calculationIndexStr = NSMutableAttributedString(string: InfoText.calculationIndexTitle.rawValue,
                                                            attributes: titleAttr as [NSAttributedString.Key : Any])
        calculationIndexStr.append(NSAttributedString(string: InfoText.calculationIndex1.rawValue,
                                                      attributes: calculationIndexAttr as [NSAttributedString.Key : Any]))
        return calculationIndexStr
    }
    
    func resultFGIStr() -> NSMutableAttributedString {
        let titleAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.medium.rawValue,
                                                                        weight: UIFont.Weight(rawValue: FontSize.weight.rawValue))]
        let resultFGIStr = NSMutableAttributedString(string: InfoText.resultFGItitle.rawValue,
                                                      attributes: titleAttr as [NSAttributedString.Key : Any])
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI1.rawValue, attributes: self.setColorText(color: .black)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI2.rawValue, attributes: self.setColorText(color: .red)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI3.rawValue, attributes: self.setColorText(color: .orange)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI4.rawValue, attributes: self.setColorText(color: .gray)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI5.rawValue, attributes: self.setColorText(color: .green)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI6.rawValue, attributes: self.setColorText(color: .systemGreen)))
        return resultFGIStr
    }
    
    func setColorText(color: UIColor) -> [NSAttributedString.Key : NSObject] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.medium.rawValue), NSAttributedString.Key.foregroundColor: color]
    }
    
    func customizeScrollView() {
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.addSubview(self.stackView)
        self.scrollView.contentSize = self.stackView.frame.size
    }
    
    func customizeStackView() {
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .fill
        self.stackView.spacing = ViewConstraints.marginSmall.rawValue
        self.stackView.addArrangedSubview(self.annotation)
        self.stackView.addArrangedSubview(self.calculationIndex)
        self.stackView.addArrangedSubview(self.resultFGI)
        self.stackView.addArrangedSubview(self.conclusion)
    }
    
    func setConstraints() {
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: ViewConstraints.heightButtons.rawValue).isActive = true
        self.backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstraints.topInfo.rawValue).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.margin.rawValue).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewConstraints.top.rawValue).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalToConstant: self.frame.size.width - ViewConstraints.left.rawValue * 2).isActive = true
    }
}
