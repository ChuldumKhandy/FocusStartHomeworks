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
    private let selectButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.size.width, right: 0)
        self.addSubview(iconImageView)
        self.addSubview(brandLable)
        self.addSubview(selectButton)
        self.customizeIcon()
        self.customizeLable()
        self.customizeButton()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChooseSceneCell {
    func customizeIcon() {
        self.iconImageView.layer.cornerRadius = IconMetrics.radius.rawValue
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.clipsToBounds = true
        self.iconImageView.backgroundColor = MainPalette.greenPrimary
    }
    
    func customizeLable() {
        self.brandLable.text = "CARS"
        self.brandLable.font = UIFont.init(name: "Inter", size: 16)
        self.brandLable.textColor = .black
        self.brandLable.numberOfLines = 0
        self.brandLable.adjustsFontSizeToFitWidth = true
    }
    
    func customizeButton() {
        self.selectButton.setTitle("Select", for: .normal)
        self.selectButton.setTitleColor(.black, for: .normal)
        self.selectButton.titleLabel?.font = UIFont.init(name: "Inter", size: 14)
        self.selectButton.titleLabel?.font = self.selectButton.titleLabel?.font.withSize(14)
        self.selectButton.backgroundColor = .white
        //self.selectButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
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
        
        self.selectButton.translatesAutoresizingMaskIntoConstraints = false
        self.selectButton.topAnchor.constraint(equalTo: self.iconImageView.topAnchor).isActive = true
        self.selectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
