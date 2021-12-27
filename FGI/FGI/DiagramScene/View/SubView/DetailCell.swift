//
//  DetailCell.swift
//  FGI
//
//  Created by user on 25.12.2021.
//

import UIKit

final class DetailCell: UITableViewCell {
    static let identifier = "ItemCollectionViewCell"
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.valueLabel)
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(date: String, value: Float) {
        self.dateLabel.text = date
        self.valueLabel.text = String(value)
        switch value {
        case 0...25:
            self.descriptionLabel.text = "инвесторы напуганы"
        case 25...49:
            self.descriptionLabel.text = "на рынке преобладает страх"
        case 49...51:
            self.descriptionLabel.text = "нейтральный настрой"
        case 51...75:
            self.descriptionLabel.text = "на рынке преобладает жадность"
        default:
            self.descriptionLabel.text = "инвесторы категорично жадны"
        }
    }
}

private extension DetailCell {
    func setConstraints() {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 5).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.valueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
