//
//  InfoView.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit

protocol IInfoView: UIView {
    var onTouchedHandler: (() -> Void)? { get set }
}

final class InfoView: UIView {
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let annotation = UILabel()
    private let calculationIndex = UILabel()
    private let resultFGI = UILabel()
    private let conclusion = UILabel()
    var onTouchedHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.scrollView)
        self.addSubview(self.titleLabel)
        self.customizeScrollView()
        self.customizeLables()
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
    func customizeLables() {
        UILabel.appearance().textAlignment = .natural
        UILabel.appearance().textColor = .black
        UILabel.appearance().numberOfLines = 0
        UILabel.appearance().lineBreakMode = .byWordWrapping

        self.titleLabel.text = InfoText.title.rawValue
        self.titleLabel.font = .boldSystemFont(ofSize: 20)
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
            self.onTouchedHandler?()
        }
    }
    
    func annotationStr() -> NSMutableAttributedString {
        let annotationAttr = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 18)]
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
        let titleAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 300))]
        let calculationIndexAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let calculationIndexStr = NSMutableAttributedString(string: InfoText.calculationIndexTitle.rawValue,
                                                      attributes: titleAttr as [NSAttributedString.Key : Any])
        calculationIndexStr.append(NSAttributedString(string: InfoText.calculationIndex1.rawValue,
                                                      attributes: calculationIndexAttr as [NSAttributedString.Key : Any]))
        return calculationIndexStr
    }
    
    func resultFGIStr() -> NSMutableAttributedString {
        let titleAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 300))]
        let resultFGIStr = NSMutableAttributedString(string: InfoText.resultFGItitle.rawValue,
                                                      attributes: titleAttr as [NSAttributedString.Key : Any])
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI1.rawValue, attributes: self.setColorText(color: UIColor.black)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI2.rawValue, attributes: self.setColorText(color: UIColor.red)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI3.rawValue, attributes: self.setColorText(color: UIColor.orange)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI4.rawValue, attributes: self.setColorText(color: UIColor.gray)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI5.rawValue, attributes: self.setColorText(color: UIColor.green)))
        resultFGIStr.append(NSAttributedString(string: InfoText.resultFGI6.rawValue, attributes: self.setColorText(color: UIColor.systemGreen)))
        return resultFGIStr
    }
    
    func setColorText(color: UIColor) -> [NSAttributedString.Key : NSObject] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: color]
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
        self.stackView.spacing = 8
        self.stackView.addArrangedSubview(self.annotation)
        self.stackView.addArrangedSubview(self.calculationIndex)
        self.stackView.addArrangedSubview(self.resultFGI)
        self.stackView.addArrangedSubview(self.conclusion)
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
