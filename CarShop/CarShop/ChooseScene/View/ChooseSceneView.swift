//
//  ChooseSceneView.swift
//  CarShop
//
//  Created by user on 05.12.2021.
//

import UIKit

protocol IChooseSceneView: UIView {
    var tableView: ChooseSceneTableView { get }
}

final class ChooseSceneView: UIView {
    var tableView = ChooseSceneTableView()
    private let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension ChooseSceneView: IChooseSceneView {
}

private extension ChooseSceneView {
    func customizeView() {
        self.backgroundColor = .white
        self.addSubview(headerLabel)
        self.addSubview(tableView)
        self.customizeLabel()
        self.setConstraints()
    }
    
    func customizeLabel() {
        self.headerLabel.text = "Выберите"
        self.headerLabel.textColor = .black
        self.headerLabel.font = UIFont(name: "Inter", size: FontSize.megaLarge.rawValue)
        self.headerLabel.font = headerLabel.font.withSize(FontSize.megaLarge.rawValue)
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
