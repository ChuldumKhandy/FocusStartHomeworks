//
//  ChooseSceneView.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

class ChooseSceneView: UIView {
    var tableView = UITableView()
    let headerLabel = UILabel()
    
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
        titleLabel.text = "Марку машины"
        titleLabel.font = UIFont(name: "Inter", size: 16)
        titleLabel.font = titleLabel.font.withSize(24)
        titleLabel.textColor = .black
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }
}

private extension ChooseSceneView {
    func customizeView() {
        self.backgroundColor = .white
        self.addSubview(headerLabel)
        self.addSubview(tableView)
        self.customizeLabel()
        self.customizeTableView()
        self.setConstraints()
    }
    
    func customizeLabel() {
        self.headerLabel.text = "Выберите"
        self.headerLabel.textColor = .black
        self.headerLabel.font = UIFont(name: "Inter", size: 20)
        self.headerLabel.font = headerLabel.font.withSize(30)
    }
    
    func customizeTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedSectionHeaderHeight = 50
        self.tableView.register(ChooseSceneCell.self, forCellReuseIdentifier: ChooseSceneCell.identifier)
    }
    
    func setConstraints() {
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: PageHeader.top.rawValue).isActive = true
        self.headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.headerLabel.heightAnchor.constraint(equalToConstant: PageHeader.height.rawValue).isActive = true
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: CellMetrics.top.rawValue).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CellMetrics.left.rawValue).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -CellMetrics.left.rawValue).isActive = true
    }
}
