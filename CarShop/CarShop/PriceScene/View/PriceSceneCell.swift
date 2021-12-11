//
//  PriceSceneCell.swift
//  CarShop
//
//  Created by user on 07.12.2021.
//

import UIKit

class PriceSceneCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    let bodyLabel = UILabel()
    let radioImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.size.width, right: 0)
        self.selectionStyle = .none
        self.addSubview(bodyLabel)
        self.addSubview(radioImageView)
        self.customizeLable()
        self.customizeIcon()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectedImageViewCell() {
        self.radioImageView.image = UIImage(systemName: "checkmark.circle")
    }
    
    func setBody(body: String?) {
        guard let body = body else { return }
        self.bodyLabel.text = body
    }
}

private extension PriceSceneCell {
    func customizeLable() {
        self.bodyLabel.font = UIFont.init(name: "Inter", size: FontSize.medium.rawValue)
        self.bodyLabel.textColor = .black
        self.bodyLabel.numberOfLines = 0
        self.bodyLabel.adjustsFontSizeToFitWidth = true
    }
    
    func customizeIcon() {
        self.radioImageView.image = UIImage(systemName: "circle")
        self.radioImageView.tintColor = MainPalette.greenPrimary
    }
    
    func setConstraints() {
        self.bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bodyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        self.radioImageView.translatesAutoresizingMaskIntoConstraints = false
        self.radioImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.radioImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
