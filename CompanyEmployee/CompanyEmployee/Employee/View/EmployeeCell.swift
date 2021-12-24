//
//  EmployeeCell.swift
//  CompanyEmployee
//
//  Created by user on 16.12.2021.
//

import UIKit

final class EmployeeCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    private let nameEmployeeLabel = UILabel()
    private let ageEmployeeLabel = UILabel()
    private let experienceEmployeeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.nameEmployeeLabel)
        self.contentView.addSubview(self.ageEmployeeLabel)
        self.contentView.addSubview(self.experienceEmployeeLabel)
        self.customizeLabels()
        self.setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfoEmployee(name: String, age: Int, experience: Float?) {
        self.nameEmployeeLabel.text = "Имя сотрудника: \(name)"
        self.ageEmployeeLabel.text = "Возраст: \(age)"
        if let experience = experience {
            self.experienceEmployeeLabel.text = "Стаж: \(experience)"
        } else {
            self.experienceEmployeeLabel.text = "Стаж: -"
        }
    }
}

private extension EmployeeCell {
    func customizeLabels() {
        self.nameEmployeeLabel.font = UIFont.systemFont(ofSize: 16)
        self.nameEmployeeLabel.textColor = .black
        
        self.ageEmployeeLabel.font = UIFont.systemFont(ofSize: 16)
        self.ageEmployeeLabel.textColor = .black
        
        self.experienceEmployeeLabel.font = UIFont.systemFont(ofSize: 14)
        self.experienceEmployeeLabel.textColor = .black
    }

    func setConstraint() {
        self.nameEmployeeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameEmployeeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.nameEmployeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.nameEmployeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.ageEmployeeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.ageEmployeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.ageEmployeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.ageEmployeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.experienceEmployeeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.experienceEmployeeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.experienceEmployeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.experienceEmployeeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
}
