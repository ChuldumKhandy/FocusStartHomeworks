//
//  ItemCollectionViewCell.swift
//  CollectionApp
//
//  Created by user on 17.11.2021.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "ItemCollectionViewCell"
    private let icon = UIImageView()
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let widthCell = contentView.frame.size.width
        let heightCell = contentView.frame.size.height
        icon.frame = CGRect(x: 0,
                            y: 0,
                            width: widthCell,
                            height: heightCell * 0.8)
        title.frame = CGRect(x: 0,
                             y: heightCell * 0.8,
                             width: widthCell,
                             height: heightCell * 0.2)
    }
    
    func configureCell(name: String, iconName: String) {
        icon.image = UIImage(named: iconName)
        icon.contentMode = .scaleAspectFit
        
        title.text = name
        title.textColor = .black
        title.textAlignment = .center
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 0
    }
}
