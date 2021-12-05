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
        self.backgroundColor = .blue
        self.customizeTableView()
        self.addSubview(tableView)
        
    }
    
    func customizeTableView() {
        self.tableView = UITableView(frame: self.bounds)
        self.tableView.register(ChooseSceneTVCell.self, forCellReuseIdentifier: ChooseSceneTVCell.identifier)
    }
}
