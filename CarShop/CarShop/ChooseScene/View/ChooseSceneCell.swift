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
    private let bottomBorder = CALayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(iconImageView)
        self.addSubview(brandLable)
        self.addSubview(selectButton)
        self.layer.addSublayer(bottomBorder)
        self.customizeIcon()
        self.customizeLable()
        self.customizeButton()
        self.customizeLayer()
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
        self.brandLable.font = .boldSystemFont(ofSize: 16)
        self.brandLable.textColor = .black
        self.brandLable.numberOfLines = 0
        self.brandLable.adjustsFontSizeToFitWidth = true
    }
    
    func customizeButton() {
        self.selectButton.setTitle("Select", for: .normal)
        self.selectButton.setTitleColor(.black, for: .normal)
        self.selectButton.titleLabel?.font = .systemFont(ofSize: 14)
        self.selectButton.backgroundColor = .white
        //self.selectButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    func customizeLayer() {
        self.bottomBorder.frame = CGRect(x: CellMetrics.left.rawValue,
                                         y: CellMetrics.height.rawValue,
                                         width: CellMetrics.width.rawValue,
                                         height: 1)
        self.bottomBorder.backgroundColor = MainPalette.gray.cgColor
    }
    
    func setConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: IconMetrics.top.rawValue).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: IconMetrics.size.rawValue).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: IconMetrics.size.rawValue).isActive = true
        self.iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CellMetrics.left.rawValue).isActive = true
        
        self.brandLable.translatesAutoresizingMaskIntoConstraints = false
        self.brandLable.topAnchor.constraint(equalTo: self.iconImageView.topAnchor).isActive = true
        self.brandLable.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: CellMetrics.left.rawValue).isActive = true
        
        self.selectButton.translatesAutoresizingMaskIntoConstraints = false
        self.selectButton.topAnchor.constraint(equalTo: self.iconImageView.topAnchor).isActive = true
        self.selectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -CellMetrics.left.rawValue).isActive = true
    }
}
