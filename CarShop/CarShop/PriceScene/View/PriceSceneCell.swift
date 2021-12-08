//
//  PriceSceneCell.swift
//  CarShop
//
//  Created by user on 07.12.2021.
//

import UIKit

class PriceSceneCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    private let brandLable = UILabel()
    private let radioButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.size.width, right: 0)
        self.addSubview(brandLable)
        self.addSubview(radioButton)
        self.customizeLable()
        self.customizeButton()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PriceSceneCell {
    func customizeLable() {
        self.brandLable.text = "Кузов"
        self.brandLable.font = UIFont.init(name: "Inter", size: 16)
        self.brandLable.textColor = .black
        self.brandLable.numberOfLines = 0
        self.brandLable.adjustsFontSizeToFitWidth = true
    }
    
    func customizeButton() {
        self.radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
        self.radioButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .highlighted)
        self.radioButton.tintColor = MainPalette.greenPrimary
        self.radioButton.addTarget(self, action: #selector(isPressed(sender:)), for: .touchDown)
    }
    
    @objc func isPressed(sender: UIButton) {
        
    }
    
    func setConstraints() {
        self.brandLable.translatesAutoresizingMaskIntoConstraints = false
        self.brandLable.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.brandLable.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        self.radioButton.translatesAutoresizingMaskIntoConstraints = false
        self.radioButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.radioButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
