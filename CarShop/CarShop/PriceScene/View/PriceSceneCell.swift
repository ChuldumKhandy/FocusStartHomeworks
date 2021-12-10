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
    private let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.size.width, right: 0)
        self.selectionStyle = .none
        self.addSubview(brandLable)
        self.addSubview(iconImageView)
        self.customizeLable()
        self.customizeIcon()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeImageViewCell() {
        self.iconImageView.image = UIImage(systemName: "circle.inset.filled")
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
    
    func customizeIcon() {
        self.iconImageView.image = UIImage(systemName: "circle")
        self.iconImageView.tintColor = MainPalette.greenPrimary
    }
    
    func setConstraints() {
        self.brandLable.translatesAutoresizingMaskIntoConstraints = false
        self.brandLable.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.brandLable.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
