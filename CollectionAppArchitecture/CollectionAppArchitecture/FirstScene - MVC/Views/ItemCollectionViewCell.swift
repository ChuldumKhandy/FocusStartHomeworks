//
//  ItemCollectionViewCell.swift
//  CollectionAppArchitecture
//
//  Created by user on 26.11.2021.
//

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "ItemCollectionViewCell"
    private let icon = UIImageView()
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(icon)
        self.contentView.addSubview(title)
        self.contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let widthCell = contentView.frame.size.width
        let heightCell = contentView.frame.size.height
        self.icon.frame = CGRect(x: 0,
                            y: 0,
                            width: widthCell,
                            height: heightCell * 0.8)
        self.title.frame = CGRect(x: 0,
                             y: heightCell * 0.8,
                             width: widthCell,
                             height: heightCell * 0.2)
    }
    
    func configureCell(name: String, iconName: String) {
        self.icon.image = UIImage(named: iconName)
        self.icon.contentMode = .scaleAspectFit
        
        self.title.text = name
        self.title.textColor = .black
        self.title.textAlignment = .center
        self.title.adjustsFontSizeToFitWidth = true
        self.title.numberOfLines = 0
    }
}
