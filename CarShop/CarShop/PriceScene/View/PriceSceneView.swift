//
//  PriceSceneView.swift
//  CarShop
//
//  Created by user on 06.12.2021.
//

import UIKit

class PriceSceneView: UIView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let calculateButton = UIButton()
    var onCellTouchHandler: (() -> Void)?
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeHeader() -> UIView {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.frame.size.height = CellMetrics.height.rawValue
        titleLabel.frame.size.width = CellMetrics.width.rawValue
        titleLabel.text = "Выберите тип кузова"
        titleLabel.font = UIFont(name: "Inter", size: FontSize.large.rawValue)
        titleLabel.font = titleLabel.font.withSize(FontSize.large.rawValue)
        titleLabel.textColor = .black
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func setCarInfo(name: String, price: String) {
        self.iconImageView.image = UIImage(named: name)
        self.priceLabel.text = price
    }
}

private extension PriceSceneView {
    func customizeView() {
        self.backgroundColor = .white
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(calculateButton)
        self.addSubview(tableView)
        self.customizeIcon()
        self.customizeLabels()
        self.customizeTableView()
        self.customizeButton()
        self.setConstraints()
    }
    
    func customizeIcon() {
        self.iconImageView.contentMode = .scaleAspectFit
    }
    
    func customizeLabels() {
        self.titleLabel.text = "Цена"
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont(name: "Inter", size: FontSize.large.rawValue)
        self.titleLabel.font = titleLabel.font.withSize(FontSize.large.rawValue)
    
        self.priceLabel.textColor = .black
        self.priceLabel.font = UIFont.init(name: "Inter", size: FontSize.medium.rawValue)
    }
    
    func customizeButton() {
        self.calculateButton.setTitle("Рассчитать цену", for: .normal)
        self.calculateButton.titleLabel?.font = UIFont.init(name: "Inter", size: FontSize.medium.rawValue)
        self.calculateButton.backgroundColor = MainPalette.greenPrimary
        self.calculateButton.layer.cornerRadius = ButtonMetrics.radius.rawValue
        self.calculateButton.addTarget(self, action: #selector(self.touchedDown), for: .touchUpInside)
        self.calculateButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func touchedDown() {
        self.onCellTouchHandler?()
    }
    
    func customizeTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedSectionHeaderHeight = CellMetrics.height.rawValue
        self.tableView.register(PriceSceneCell.self, forCellReuseIdentifier: PriceSceneCell.identifier)
    }
    
    func setConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: ImageMetrics.top.rawValue).isActive = true
        self.iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ImageMetrics.left.rawValue).isActive = true
        self.iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ImageMetrics.left.rawValue).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: ImageMetrics.height.rawValue).isActive = true

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.iconImageView.bottomAnchor, constant: LabelsMetrics.topTitle.rawValue).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LabelsMetrics.left.rawValue).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LabelsMetrics.left.rawValue).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: LabelsMetrics.heightTitle.rawValue).isActive = true
        
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: LabelsMetrics.topText.rawValue).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LabelsMetrics.left.rawValue).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LabelsMetrics.left.rawValue).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: LabelsMetrics.heightText.rawValue).isActive = true
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: LabelsMetrics.topText.rawValue).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LabelsMetrics.left.rawValue).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LabelsMetrics.left.rawValue).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.calculateButton.topAnchor, constant: 0).isActive = true
        
        self.calculateButton.translatesAutoresizingMaskIntoConstraints = false
        self.calculateButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ButtonMetrics.bottom.rawValue).isActive = true
        self.calculateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ButtonMetrics.left.rawValue).isActive = true
        self.calculateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ButtonMetrics.left.rawValue).isActive = true
        self.calculateButton.heightAnchor.constraint(equalToConstant: ButtonMetrics.height.rawValue).isActive = true
    }
}
