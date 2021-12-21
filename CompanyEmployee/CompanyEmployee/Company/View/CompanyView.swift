//
//  CompanyView.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

protocol ICompanyView: UIView {
    var tableView: UITableView { get }
}

final class CompanyView: UIView {
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
        self.customizeTableView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CompanyView: ICompanyView {
}

private extension CompanyView {
    func customizeTableView() {
        self.tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.identifier)
    }

    func setConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
