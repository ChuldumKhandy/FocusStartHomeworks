//
//  ChooseSceneTVCell.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

class ChooseSceneCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    private let iconImageView = UIImageView()
    private let brandLable = UILabel()
    private let selectLabel = UILabel()
    var onTouchedHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.size.width, right: 0)
        self.selectionStyle = .none
        self.addSubview(iconImageView)
        self.addSubview(brandLable)
        self.addSubview(selectLabel)
        self.customizeIcon()
        self.customizeLables()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func brandCar(brand: String) {
        self.brandLable.text = brand
    }
    
    func colorImage() {
        self.iconImageView.backgroundColor = MainPalette.greenSecondary
    }
}

private extension ChooseSceneCell {
    func customizeIcon() {
        self.iconImageView.layer.cornerRadius = IconMetrics.radius.rawValue
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.clipsToBounds = true
        self.iconImageView.backgroundColor = MainPalette.greenPrimary
    }
    
    func customizeLables() {
        self.brandLable.font = UIFont.init(name: "Inter", size: FontSize.medium.rawValue)
        self.brandLable.textColor = .black
        self.brandLable.numberOfLines = 0
        self.brandLable.adjustsFontSizeToFitWidth = true
        
        self.selectLabel.text = "Select"
        self.selectLabel.font = UIFont.init(name: "Inter", size: FontSize.small.rawValue)
        self.selectLabel.font = self.selectLabel.font.withSize(FontSize.small.rawValue)
        self.selectLabel.textColor = .black
        self.selectLabel.numberOfLines = 0
        self.selectLabel.adjustsFontSizeToFitWidth = true
    }

    func setConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: IconMetrics.top.rawValue).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: IconMetrics.size.rawValue).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: IconMetrics.size.rawValue).isActive = true
        self.iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        self.brandLable.translatesAutoresizingMaskIntoConstraints = false
        self.brandLable.topAnchor.constraint(equalTo: self.iconImageView.topAnchor).isActive = true
        self.brandLable.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: CellMetrics.left.rawValue).isActive = true
        
        self.selectLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectLabel.topAnchor.constraint(equalTo: self.iconImageView.topAnchor).isActive = true
        self.selectLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
