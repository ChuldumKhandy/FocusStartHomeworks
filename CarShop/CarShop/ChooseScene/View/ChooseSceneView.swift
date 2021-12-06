//
//  ChooseSceneView.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

class ChooseSceneView: UIView {
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ChooseSceneView {
    func customizeView() {
        self.backgroundColor = .white
        self.customizeTableView()
        self.addSubview(tableView)
        
    }
    
    func customizeTableView() {
        self.tableView = UITableView(frame: self.bounds)
        self.tableView.separatorColor = .clear
        self.tableView.register(ChooseSceneCell.self, forCellReuseIdentifier: ChooseSceneCell.identifier)
    }
    
    func setConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.tableView.widthAnchor.constraint(equalToConstant: CellMetrics.width.rawValue).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: CellMetrics.width.rawValue).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CellMetrics.left.rawValue).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -CellMetrics.left.rawValue).isActive = true
    }
}
