//
//  CompanyCell.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import UIKit

final class CompanyCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    private let nameCompanyLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.nameCompanyLabel)
        self.customizeLabel()
        self.setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setnameCompany(name: String?) {
        if let name = name {
            self.nameCompanyLabel.text = name
        }
    }
}

private extension CompanyCell {
    func customizeLabel() {
        self.nameCompanyLabel.font = UIFont.systemFont(ofSize: 16)
        self.nameCompanyLabel.textColor = .black
    }

    func setConstraint() {
        self.nameCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameCompanyLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.nameCompanyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.nameCompanyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.nameCompanyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
